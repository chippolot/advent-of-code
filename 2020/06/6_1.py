groups = open('input.txt', 'r').read().split('\n\n')

counts = [len(set(group).difference('\n')) for group in groups]
print(sum(counts))