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

def shortest_route(id, path, distance):
	path = path + [id]
	if len(path) == len(nodes):
		return distance

	node = nodes[id]

	shortest_dist = sys.maxint
	for connection in node:
		connection_id = connection['id']
		if connection_id in path:
			continue
		shortest_dist = min(shortest_dist, shortest_route(connection_id, path, distance + connection['distance']))
	return shortest_dist

for line in file:
	tokens = line.rstrip().split(" ")
	add_connection(tokens[0], tokens[2], int(tokens[4]))
print min(shortest_route(node_id, [], 0) for node_id in nodes.keys())