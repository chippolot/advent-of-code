def countarrangements(nums, i, memo):
    if i in memo:
        return memo[i]
    sum = 0
    for j in range(i + 3, i, -1):
        if j in nums and j - i <= 3:
            sum += countarrangements(nums, j, memo)
    memo[i] = sum
    return sum

nums = list(map(int, open('input.txt', 'r').read().splitlines()))
nums.sort()
nums = [0] + nums + [nums[-1] + 3]

memo = {}
memo[nums[len(nums)-1]] = 1
nums = set(nums)

combos = countarrangements(nums, 0, memo)
print(combos)

"""
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
"""