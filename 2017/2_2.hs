checksumLine :: String -> Int
checksumLine line = 
    let nums = map (read::String->Int) (words line)
        in head [x `div` y | x <- nums, y <- nums, x `rem` y == 0, x /= y]

main = do
    input <- readFile "input.txt"
    let checksum = sum $ map checksumLine $ lines input
    print checksum