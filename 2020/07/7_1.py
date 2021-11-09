map = {}
seen = set()

def traversecontainers(color):
    print(color)
    if color in seen:
        return
    seen.add(color)
    if color in map:
        for c in map[color]:
            traversecontainers(c)


lines = open('input.txt', 'r').read().splitlines()

counting_color = 'shiny gold'

for line in lines:
    color, rules = line.split(' bags contain ')
    rules = rules[:-1] # strip .
    if rules == 'no other bags':
        continue
    else:
        rules = rules.split(', ')
        for rule in rules:
            toks = rule.split(' ')
            inner_num = int(toks[0])
            inner_color = ' '.join(toks[1:-1])
            map[inner_color] = map.get(inner_color, []) + [color]

traversecontainers(counting_color)
print(len(seen) - 1)