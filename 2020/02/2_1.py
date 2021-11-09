import re

lines = open('input.txt', 'r').readlines()

num_valid = 0
for line in lines:
    groups = re.search('(\d+)-(\d+) (\w): (\w+)', line)
    min = int(groups.group(1))
    max = int(groups.group(2))
    chr = groups.group(3)
    str = groups.group(4)
    chr_cnt = str.count(chr)
    if chr_cnt >= min and chr_cnt <= max:
        num_valid += 1
print(num_valid)
