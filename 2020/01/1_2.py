import sys

file = open('input.txt', 'r')
lines = file.readlines()

target = 2020
num_map = {}
nums = []

for line in lines:
    num = int(line)
    nums.append(num)
    num_map[num] = True

for num1 in nums:
    for num2 in nums:
        rem = target - (num1 + num2)
        if rem > 0:
            if rem in nums:
                print(f"{num1} {num2} {rem} = {num1 * num2 * rem}")
                sys.exit(0)