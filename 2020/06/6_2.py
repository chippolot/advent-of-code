groups = open('input.txt', 'r').read().split('\n\n')

sum = 0
for group in groups:
    entries = [set(x) for x in group.split('\n')]
    common = entries[0].intersection(*entries)
    sum += len(common)
print(sum)