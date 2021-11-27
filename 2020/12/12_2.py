dirs = ['E', 'S', 'W', 'N']
vecs = {'E': (1,0), 'S': (0,-1), 'W': (-1,0), 'N': (0,1)}

def manhattan_dist(x, y):
    return abs(x) + abs(y)

def turn_90_degrees(x, y, degrees):
    steps = abs(degrees) / 90
    for i in range(0, steps):
        if degrees > 0:
            x,y = y,-x
        else:
            x,y = -y,x
    return x,y

def run(commands, x, y, wx, wy):
    for command in commands:
        c = command[0]
        n = int(command[1:])
        if c in vecs:
            dx, dy = vecs[c]
            wx += dx * n
            wy += dy * n
        elif c == 'F':
            x += wx * n
            y += wy * n
        else:
            if c == 'L':
                n *= -1
            wx, wy = turn_90_degrees(wx, wy, n)
    return (x,y)

commands = open('input.txt', 'r').read().splitlines()
x, y = run(commands, 0, 0, 10, 1)
dist = manhattan_dist(x,y)
print(dist)