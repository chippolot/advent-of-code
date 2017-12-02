import Data.Char (digitToInt)

sumMatchingDigits :: String -> Int
sumMatchingDigits input = 
    let list1 = map digitToInt input
        halfLen = length list1 `div` 2
        (listA, listB) = splitAt halfLen list1
        list2 = listB ++ listA
    in sum [x | (x,y) <- (zip list1 list2), x == y]

main = do
    input <- readFile "input.txt"
    print $ sumMatchingDigits input