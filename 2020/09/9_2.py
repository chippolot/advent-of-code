def findweakness(target, nums):
    cnt = 2
    i = 0

    while i < len(nums):
        rng = nums[i:i+cnt]
        rngsum = sum(rng)
        if i + cnt >= len(nums) or rngsum > target:
            i += 1
            cnt = 2
            continue
        
        if rngsum == target:
            return min(rng) + max(rng)
        cnt += 1
    return None

nums = list(map(int, open('input.txt', 'r').read().splitlines()))
res = findweakness(70639851, nums)
print (res)
