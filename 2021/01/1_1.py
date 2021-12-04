nums = list(map(int, open('input.txt', 'r').read().splitlines()))

increases = 0

last = nums[0]
for num in nums:
    if num > last:
        increases += 1
    last = num

print(increases)