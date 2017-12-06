{-
Out of curiosity, the debugger would also like to know the size of the loop: starting from a state that has already been seen, how many block redistribution cycles must be performed before that same state is seen again?

In the example above, 2 4 1 2 is seen again after four cycles, and so the answer in that example would be 4.

How many cycles are in the infinite loop that arises from the configuration in your puzzle input?
-}

import Data.List
import Data.Maybe
import qualified Data.Vector as V
import Data.Vector (Vector, (!), (//))
import qualified Data.Set as S
import Data.Set (Set)

reallocBanks :: Vector Int -> Vector Int
reallocBanks banks =
    let maxIdx = V.maxIndex banks
        val = banks ! maxIdx
        numBanks = length banks
        banks' = banks // [(maxIdx, 0)]
        reallocs = [((maxIdx + i) `mod` numBanks, 1) | i <- [1..val]]
    in V.accum (+) banks' reallocs

reallocBanksUntilLoop :: Vector Int -> [Vector Int]
reallocBanksUntilLoop banks =
     unfoldr step (S.empty, Just banks) where
        step (history, maybeBanks)
            | isNothing maybeBanks = Nothing
            | S.member banks history = Just(banks, (history, Nothing))
            | otherwise = Just(banks, (S.insert banks history, Just banks')) where
            banks = fromJust maybeBanks
            banks' = reallocBanks banks

main = do
    input <- readFile "input.txt"
    let banks = map (read::String->Int) $ words input
    let banksVec = V.fromList banks
    let reallocSteps = reallocBanksUntilLoop banksVec
    let loopValue = last reallocSteps
    let minLoopValueIdx = fromJust $ elemIndex loopValue reallocSteps
    print (((length reallocSteps) - 1) - minLoopValueIdx)