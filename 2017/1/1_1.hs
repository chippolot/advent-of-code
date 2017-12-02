import Data.Char (digitToInt)

sumMatchingDigits :: String -> Int
sumMatchingDigits input = 
    let list1 = map digitToInt input
        list2 = tail $ take (length list1 + 1) (cycle list1)
    in sum [x | (x,y) <- (zip list1 list2), x == y]

main = do
    input <- readFile "input.txt"
    print $ sumMatchingDigits input