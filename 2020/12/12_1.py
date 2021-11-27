dirs = ['E', 'S', 'W', 'N']
vecs = {'E': (1,0), 'S': (0,-1), 'W': (-1,0), 'N': (0,1)}

def manhattan_dist(x, y):
    return abs(x) + abs(y)

def turn(dir, degrees):
    steps = degrees / 90
    idx = dirs.index(dir)
    idx = (idx + steps) % len(dirs)
    return dirs[idx]

def run(commands, x, y, dir):
    for command in commands:
        c = command[0]
        n = int(command[1:])
        if c in vecs:
            dx, dy = vecs[c]
            x += dx * n
            y += dy * n
        elif c == 'F':
            dx, dy = vecs[dir]
            x += dx * n
            y += dy * n
        else:
            degrees = n
            if c == 'L':
                degrees *= -1
            dir = turn(dir, degrees)
    return (x,y)

commands = open('input.txt', 'r').read().splitlines()
x, y = run(commands, 0, 0, 'E')
dist = manhattan_dist(x,y)
print(dist)