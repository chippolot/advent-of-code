lines = open('input.txt', 'r').read().splitlines()

required_fields = {'byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid'}
curr_required_fields = required_fields.copy()
num_valid_passports = 0

for line in lines:
    if not line:
        if len(curr_required_fields) == 0:
            num_valid_passports += 1
        curr_required_fields = required_fields.copy()
        continue
    toks = line.split(" ")
    for tok in toks:
        id, val = tok.split(':')
        curr_required_fields.discard(id)

if len(curr_required_fields) == 0:
    num_valid_passports += 1

print(num_valid_passports)