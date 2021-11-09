lines = open('input.txt', 'r').readlines()
map = []
for line in lines:
    map.append(list(line.rstrip()))
    
dx = 3
dy = 1
x = y = 0
height = len(map)
width = len(map[0])
num_trees = 0

while y < height:
    c = map[y][(x % width)]
    if c == '#':
        num_trees += 1
    x += dx
    y += dy
print(num_trees)