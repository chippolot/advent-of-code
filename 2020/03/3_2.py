lines = open('input.txt', 'r').readlines()
map = []
for line in lines:
    map.append(list(line.rstrip()))
    
slopes = [(1,1), (3,1), (5,1), (7,1), (1,2)]
height = len(map)
width = len(map[0])
product = 1

for slope in slopes:
    dx, dy = slope
    x = y = 0
    num_trees = 0
    while y < height:
        c = map[y][(x % width)]
        if c == '#':
            num_trees += 1
        x += dx
        y += dy
    product *= num_trees

print(product)