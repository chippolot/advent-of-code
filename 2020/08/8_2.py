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

def runcommands(commands, idx, acc, changed):
    while idx != len(commands):
        if not commands[idx] or idx > len(commands):
            return (False, 0)
        command, num = commands[idx]

        if not changed and (command == 'nop' or command == 'jmp'):
            newcommands = commands.copy()
            newcommands[idx] = (('jmp' if command == 'nop' else 'nop'), num)
            completed, newacc  = runcommands(newcommands, idx, acc, True)
            if completed:
                return (True, newacc)

        commands[idx] = None
        if command == 'nop':
            idx += 1
        elif command == 'acc':
            idx += 1
            acc += num
        elif command == 'jmp':
            idx += num
    return (True, acc)
        

commands = parseinput()
result, acc = runcommands(commands, 0, 0, False)
print(acc)