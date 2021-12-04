# NOT SOLVED

lines = open('input.txt', 'r').read().splitlines()
busses = lines[1].split(',')

solved = False
t = 0
step = int(busses[0])

while not solved:
    t += step
    solved = True
    for i in range(1, len(busses)):
        bus = busses[i]
        if bus == 'x':
            continue
        bus = int(bus)
        if (t + i) % bus != 0:
            solved = False
            break
print(t)
