import copy

def print_state(state):
    for row in state:
        print(row)
    print()

def num_adjacent_occupied(x, y, w, h, state):
    num = 0
    for xi in range(x-1, x+2):
        for yi in range(y-1, y+2):
            if xi >= 0 and xi < w and yi >= 0 and yi < h:
                if state[yi][xi] == '#':
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

def process(state):
    dirty = True
    while dirty:
        dirty = False
        next_state = copy.deepcopy(state)
        h = len(state)
        w = len(state[0])
        for y in range(0, h):
            for x in range(0, w):
                c = state[y][x]
                if c == '.':
                    continue
                n = num_adjacent_occupied(x,y,w,h,state)
                if n == 0 and c != '#':
                    next_state[y][x] = '#'
                    dirty = True
                elif n > 4 and c != 'L':
                    next_state[y][x] = 'L'
                    dirty = True
        state = next_state
        if not dirty:
            break
    return count_occupied(state)
            

state = map(list,open('input.txt', 'r').read().splitlines())
num_occupied = process(state)
print(num_occupied)