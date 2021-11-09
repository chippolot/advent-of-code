nums = list(map(int, open('input.txt', 'r').read().splitlines()))
nums.sort()
nums = [0] + nums + [nums[-1] + 3]

jlt_ones = 0
jlt_threes = 0
for i in range(1, len(nums)):
    diff = nums[i] - nums[i-1]
    if diff == 1:
        jlt_ones += 1
    elif diff == 3:
        jlt_threes +=1
print(jlt_ones * jlt_threes)
