file = open("3_1_input.txt", "r")
str = file.read()
directions = {'^':(0,1),'v':(0,-1),'<':(-1,0),'>':(1,0)}
x,y=0,0
deliveries={(0,0):1}

for c in str:
	t = directions[c]
	x,y=x+t[0],y+t[1]
	deliveries[(x,y)] = deliveries.get((x,y), 0) + 1

print len(deliveries)