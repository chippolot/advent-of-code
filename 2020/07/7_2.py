map = {}

def countbags(color):
    if color not in map:
        return 0
    sum = 0
    for inner_num, inner_color in map[color]:
        sum += inner_num + inner_num * countbags(inner_color)
    return sum

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
            map[color] = map.get(color, []) + [(inner_num, inner_color)]

count = countbags(counting_color)
print(count)