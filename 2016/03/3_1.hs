{-
Now that you can think clearly, you move deeper into the labyrinth of hallways and office furniture that makes up this part of Easter Bunny HQ. This must be a graphic design department; the walls are covered in specifications for triangles.

Or are they?

The design document gives the side lengths of each triangle it describes, but... 5 10 25? Some of these aren't triangles. You can't help but mark the impossible ones.

In a valid triangle, the sum of any two sides must be larger than the remaining side. For example, the "triangle" given above is impossible, because 5 + 10 is not larger than 25.

In your puzzle input, how many of the listed triangles are possible?
-}

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
    print $ (length . filter validTri) tris 