lines = open('input.txt', 'r').read().splitlines()

x = 0
y = 0
for line in lines:
    tokens = line.split(' ')
    cmd = tokens[0]
    num = int(tokens[1])
    if cmd == "forward":
        x += num
    elif cmd == "up":
        y -= num
    elif cmd == "down":
        y += num
print(x*y)