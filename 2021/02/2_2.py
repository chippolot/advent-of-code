lines = open('input.txt', 'r').read().splitlines()

aim = 0
x = 0
y = 0

for line in lines:
    tokens = line.split(' ')
    cmd = tokens[0]
    num = int(tokens[1])
    if cmd == "forward":
        x += num
        y += aim * num
    elif cmd == "up":
        aim -= num
    elif cmd == "down":
        aim += num
print(x*y)