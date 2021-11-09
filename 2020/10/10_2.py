def countarrangements(nums, i):
    if i == (len(nums) - 1):
        return 1
    sum = 0
    for j in range(i + 1, len(nums)):
        if nums[j] - nums[i] <= 3:
            sum += countarrangements(nums, j)
        else:
            break
    return sum

nums = list(map(int, open('input.txt', 'r').read().splitlines()))
nums.sort()
nums = [0] + nums + [nums[-1] + 3]

combos = countarrangements(nums, 0)
print(combos)
