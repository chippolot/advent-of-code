nums = list(map(int, open('input.txt', 'r').read().splitlines()))

increases = 0

lastsum = nums[0] + nums[1] + nums[2]
for i in range(3, len(nums)):
    sum = nums[i] + nums[i-1] + nums[i-2]
    if sum > lastsum:
        increases += 1
    lastsum = sum

print(increases)