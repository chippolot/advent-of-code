def findsumbetween(sum, nums):
    numset = set(nums)
    for num in numset:
        rem = sum - num
        if rem in numset:
            return True
    return False

nums = list(map(int, open('input.txt', 'r').read().splitlines()))

preamble_len = 25
for i in range(preamble_len, len(nums)):
    if not findsumbetween(nums[i], nums[i - preamble_len : i + preamble_len]):
        print(nums[i])
        break
else:
    print("None")
