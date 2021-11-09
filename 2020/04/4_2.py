def validate_field(id, val):
    try:
        if id == 'byr':
            yr = int(val)
            return yr >= 1920 and yr <= 2002
        elif id == 'iyr':
            yr = int(val)
            return yr >= 2010 and yr <= 2020
        elif id == 'eyr':
            yr = int(val)
            return yr >= 2020 and yr <= 2030
        elif id == 'hgt':
            hgt = int(val[:-2])
            if val.endswith('cm'):
                return hgt >= 150 and hgt <= 193
            elif val.endswith('in'):
                return hgt >= 59 and hgt <= 76
            else:
                return False
        elif id == 'hcl':
                return val[0] == '#' and int(val[1:], 16) >= 0
        elif id == 'ecl':
            return val == 'amb' or val =='blu' or val == 'brn' or val == 'gry' or val == 'grn' or val == 'hzl' or val == 'oth'
        elif id == 'pid':
            return len(val) == 9 and int(val) >= 0
        elif id == 'cid':
            return True
        else:
            return False
    except:
        return False

lines = open('input.txt', 'r').read().splitlines()

required_fields = {'byr', 'iyr', 'eyr', 'hgt', 'hcl', 'ecl', 'pid'}
curr_required_fields = required_fields.copy()
num_valid_passports = 0
invalid = False

for line in lines:
    if not line:
        if len(curr_required_fields) == 0 and not invalid:
            num_valid_passports += 1
        curr_required_fields = required_fields.copy()
        invalid = False
        continue
    toks = line.split(" ")
    for tok in toks:
        id, val = tok.split(':')
        valid_field = False
        if validate_field(id, val):
            curr_required_fields.discard(id)
        else:
            invalid = True
            

if len(curr_required_fields) == 0 and not invalid:
    num_valid_passports += 1

print(num_valid_passports)