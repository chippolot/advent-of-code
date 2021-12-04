lines = open('input.txt', 'r').read().splitlines()

def count_on_bits(list, bit):
    return len([1 for x in list if x & (1 << bit) != 0 ])

ogr_candidates = []
csr_candidates = []

for line in lines:
    binary = int(line,2)
    ogr_candidates.append(binary)
    csr_candidates.append(binary)

ogr_mask = 0
csr_mask = 0

num_bits = len(lines[0])
num_lines = len(lines)
for i in range(0, num_bits):
    bit = num_bits - i - 1

    ogr_ons = count_on_bits(ogr_candidates, bit)
    if ogr_ons * 2 >= len(ogr_candidates):
        ogr_mask += 1 << bit
        
    csr_ons = count_on_bits(csr_candidates, bit)
    if csr_ons * 2 < len(csr_candidates):
        csr_mask += 1 << bit

    if len(ogr_candidates) > 1:
        ogr_candidates = [x for x in ogr_candidates if x >> bit == ogr_mask >> bit]
    if len(csr_candidates) > 1:
        csr_candidates = [x for x in csr_candidates if x >> bit == csr_mask >> bit]
    if len(ogr_candidates) == 1 and len(csr_candidates) == 1:
        break

life_support_rating = ogr_candidates[0] * csr_candidates[0]
print(life_support_rating)