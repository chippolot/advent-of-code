checksumLine :: String -> Int
checksumLine line = 
    let nums = map (read::String->Int) (words line)
        maxVal = maximum nums
        minVal = minimum nums
    in maxVal - minVal


main = do
    input <- readFile "input.txt"
    let checksum = sum $ map checksumLine $ lines input
    print checksum