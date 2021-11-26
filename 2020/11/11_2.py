import copy

def print_state(state):
    for row in state:
        print(row)
    print()

def num_adjacent_occupied(x, y, w, h, state, los):
    num = 0
    for dx in range(-1, 2):
        for dy in range(-1, 2):
            if dx == 0 and dy == 0:
                continue
            xi, yi = los[(x,y,dx,dy)]
            if xi != None and state[yi][xi] == '#':
                num +=1
    return num

def count_occupied(state):
    num = 0
    h = len(state)
    w = len(state[0])
    for y in range(0, h):
        for x in range(0, w):
            if state[y][x] == '#':
                num += 1
    return num

def line_of_sight(state, x, y, w, h, dx, dy):
    x += dx
    y += dy
    while x >= 0 and x < w and y >= 0 and y < h:
        if state[y][x] != '.':
            return (x,y)
        x += dx
        y += dy
    return (None,None)

def build_line_of_sight_map(state,w,h):
    los = {}
    for x in range(0, w):
        for y in range(0, h):
            if state[y][x] == '.':
                continue
            for dx in range(-1,2):
                for dy in range(-1,2):
                    if dx == 0 and dy == 0:
                        continue
                    los[(x,y,dx,dy)] = line_of_sight(state, x, y, w, h, dx, dy)
    return los

def process(state):
    h = len(state)
    w = len(state[0])
    los = build_line_of_sight_map(state,w,h)
    dirty = True
    while dirty:
        dirty = False
        next_state = copy.deepcopy(state)
        for y in range(0, h):
            for x in range(0, w):
                c = state[y][x]
                if c == '.':
                    continue
                n = num_adjacent_occupied(x,y,w,h,state,los)
                if n == 0 and c != '#':
                    next_state[y][x] = '#'
                    dirty = True
                elif n >= 5 and c != 'L':
                    next_state[y][x] = 'L'
                    dirty = True
        state = next_state
        if not dirty:
            break
    return count_occupied(state)

state = map(list,open('input.txt', 'r').read().splitlines())
num_occupied = process(state)
print(num_occupied)