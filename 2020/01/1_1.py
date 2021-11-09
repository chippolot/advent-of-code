file = open('input.txt', 'r')
lines = file.readlines()

target = 2020
nums = {}

for line in lines:
    num = int(line)
    nums[num] = True

for num in nums:
    rem = target - num
    if rem > 0:
        if rem in nums:
            print(f"{num} {rem} = {num * rem}")
            break