import re

lines = open('input.txt', 'r').readlines()

num_valid = 0
for line in lines:
    groups = re.search('(\d+)-(\d+) (\w): (\w+)', line)
    pos1 = int(groups.group(1)) - 1
    pos2 = int(groups.group(2)) - 1
    chr = groups.group(3)
    str = groups.group(4)
    if (str[pos1] == chr) != (str[pos2] == chr):
        num_valid += 1
print(num_valid)
