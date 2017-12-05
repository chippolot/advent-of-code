import numpy as np

file = open('7_1_input.txt', 'r')

nodes = {}

def parse_connection(line):
	tokens = line.split(' ')
	op = None
	inputs = []

	# signal into named node
	if len(tokens) == 3:
		op = 'SET'
		inputs = [tokens[0]]
	# not command
	elif 'NOT' in line:
		op = tokens[0]
		inputs = [tokens[1]]
	# other command
	else:
		op = tokens[1]
		inputs = [tokens[0], tokens[2]]

	output = tokens[len(tokens) -1].rstrip()

	nodes[output] = {'id':output, 'inputs':inputs, 'op':op}

def short(id):
	return np.uint16(id)

def get_node_signal(id):
	if id.isdigit():
		return short(id)
	return nodes[id]['signal']

def evaluate_signal_for_node(id):
	if id.isdigit():
		return

	node = nodes[id]
	if 'signal' in node:
		return node['signal']

	inputs = node['inputs']

	# evaluate parent signals recursively
	for parent_input in inputs:
		evaluate_signal_for_node(parent_input)

	# initialize signal starting signal
	signal = node.get('signal', 0)

	op = node['op']

	if op == 'SET':
		signal = get_node_signal(inputs[0])
	elif op == 'AND':
		signal = get_node_signal(inputs[0]) & get_node_signal(inputs[1])
	elif op == 'OR':
		signal = get_node_signal(inputs[0]) | get_node_signal(inputs[1])
	elif op == 'LSHIFT':
		signal = get_node_signal(inputs[0]) << get_node_signal(inputs[1])
	elif op == 'RSHIFT':
		signal = get_node_signal(inputs[0]) >> get_node_signal(inputs[1])
	elif op == 'NOT':
		signal = ~get_node_signal(inputs[0])

	node['signal'] = signal
	return node['signal']


for line in file:
	parse_connection(line)

signal_a = evaluate_signal_for_node('a')
print(signal_a)
nodes['b']['signal'] = signal_a
for id in nodes:
	if id != 'b':
		nodes[id].pop('signal', 0)
print(evaluate_signal_for_node('a'))

# TEST VALIDATION
#print(evaluate_signal_for_node('d'))
#print(evaluate_signal_for_node('e'))
#print(evaluate_signal_for_node('f'))
#print(evaluate_signal_for_node('g'))
#print(evaluate_signal_for_node('h'))
#print(evaluate_signal_for_node('i'))
#print(evaluate_signal_for_node('x'))
#print(evaluate_signal_for_node('y'))