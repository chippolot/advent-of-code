{-
Now, the jumps are even stranger: after each jump, if the offset was three or more, instead decrease it by 1. Otherwise, increase it by 1 as before.

Using this rule with the above example, the process now takes 10 steps, and the offset values after finding the exit are left as 2 3 2 3 -1.

How many steps does it now take to reach the exit?
-}

import Data.List
import qualified Data.Map as Map

type OffsetMap = Map.Map Int Int

modifyOffsetAt :: Int -> Int -> OffsetMap -> OffsetMap
modifyOffsetAt key val offsets = Map.insertWith (+) key val offsets

doJumpsFromIndex :: Int -> [Int] -> [Int]
doJumpsFromIndex i offsets = 
    let numOffsets = length offsets
        offsetMap = Map.fromList $ zip [0,1..] offsets
        step (i, offsetMap)
            | i < 0 || i >= numOffsets = Nothing
            | otherwise = Just(i2, (i2, modifyOffsetAt i (if offset >= 3 then -1 else 1) offsetMap)) where 
            i2 = i + offset
            offset = Map.findWithDefault 0 i offsetMap
    in unfoldr step (i, offsetMap)
        

main = do
    input <- readFile "input.txt"
    let offsets = map (read :: String -> Int) (lines input)
    let jumps = doJumpsFromIndex 0 offsets
    print $ length jumps