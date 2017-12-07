{-
Now that you've helpfully marked up their design documents, it occurs to you that triangles are specified in groups of three vertically. Each set of three numbers in a column specifies a triangle. Rows are unrelated.

For example, given the following specification, numbers with the same hundreds digit would be part of the same triangle:

101 301 501
102 302 502
103 303 503
201 401 601
202 402 602
203 403 603
In your puzzle input, and instead reading by columns, how many of the listed triangles are possible?
-}

import Data.List
import Data.List.Split

strToInts :: String -> [Int]
strToInts str = map read $ words str :: [Int]

validTri :: [Int] -> Bool
validTri (x:y:z:[])
    | x + y <= z = False
    | x + z <= y = False
    | y + z <= x = False
    | otherwise = True

main = do
    input <- readFile "3_1_input.txt"
    let inputLines = lines input
    let tris = map strToInts inputLines
    let tris' = concatMap (chunksOf 3) $ transpose tris
    print $ (length . filter validTri) tris' 