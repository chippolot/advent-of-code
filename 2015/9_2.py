import sys

file = open('9_1_input.txt', 'r')

nodes = {}

def get_or_add_node(id):
	if id not in nodes:
		nodes[id] = []
	return nodes[id]

def add_connection(id_a, id_b, distance):
	node_a = get_or_add_node(id_a)
	node_a.append({'id':id_b, 'distance':distance})
	node_b = get_or_add_node(id_b)
	node_b.append({'id':id_a, 'distance':distance})

def list_apppend(list, item):
	list.append(item)
	return list

def longest_route(id, path, distance):
	path = path + [id]
	if len(path) == len(nodes):
		return distance

	node = nodes[id]

	longest_dist = 0
	for connection in node:
		connection_id = connection['id']
		if connection_id in path:
			continue
		longest_dist = max(longest_dist, longest_route(connection_id, path, distance + connection['distance']))
	return longest_dist

for line in file:
	tokens = line.rstrip().split(" ")
	add_connection(tokens[0], tokens[2], int(tokens[4]))
print max(longest_route(node_id, [], 0) for node_id in nodes.keys())