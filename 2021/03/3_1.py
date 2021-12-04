lines = open('input.txt', 'r').read().splitlines()

gamma = 0
epsilon = 0

num_bits = len(lines[0])
on_bits = [0] * num_bits
for line in lines:
    for i in range(0, num_bits):
        if line[i] == "1":
            on_bits[i] += 1

num_lines = len(lines)
for i in range(0, num_bits):
    mostly_ones = on_bits[i] * 2 >= num_lines
    if mostly_ones:
        gamma += 1 << (num_bits - i - 1)
    else:
        epsilon += 1 << (num_bits - i - 1)

power = gamma * epsilon
print(power)