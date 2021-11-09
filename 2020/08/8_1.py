def parseinput():
    commands = []
    lines = open('input.txt', 'r').read().splitlines()
    for line in lines:
        cmd = line[:3]
        dir = line[4:5]
        num = int(line[5:])
        if dir == '-':
            num *= -1
        commands.append((cmd, num))
    return commands

def runcommands(commands):
    acc = 0
    idx = 0
    while commands[idx]:
        command, num = commands[idx]
        commands[idx] = None
        if command == 'nop':
            idx += 1
        elif command == 'acc':
            idx += 1
            acc += num
        elif command == 'jmp':
            idx += num
    return acc
        

commands = parseinput()
acc = runcommands(commands)
print(acc)