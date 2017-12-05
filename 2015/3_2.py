file = open("3_1_input.txt", "r")
str = file.read()
directions = {'^':(0,1),'v':(0,-1),'<':(-1,0),'>':(1,0)}
coords = [[0,0],[0,0]]
deliveries={(0,0):2}

idx = 0
for c in str:
	t = directions[c]
	coords[idx][0],coords[idx][1]=coords[idx][0]+t[0],coords[idx][1]+t[1]
	deliveries[(coords[idx][0],coords[idx][1])] = deliveries.get((coords[idx][0],coords[idx][1]), 0) + 1
	idx = (idx + 1) % len(coords)

print len(deliveries)