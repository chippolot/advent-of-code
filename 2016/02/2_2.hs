{-
You finally arrive at the bathroom (it's a several minute walk from the lobby so visitors can behold the many fancy conference rooms and water coolers on this floor) and go to punch in the code. Much to your bladder's dismay, the keypad is not at all like you imagined it. Instead, you are confronted with the result of hundreds of man-hours of bathroom-keypad-design meetings:

    1
  2 3 4
5 6 7 8 9
  A B C
    D
You still start at "5" and stop when you're at an edge, but given the same instructions as above, the outcome is very different:

You start at "5" and don't move at all (up and left are both edges), ending at 5.
Continuing from "5", you move right twice and down three times (through "6", "7", "B", "D", "D"), ending at D.
Then, from "D", you move five more times (through "D", "B", "C", "C", "B"), ending at B.
Finally, after five more moves, you end at 3.
So, given the actual keypad layout, the code would be 5DB3.

Using the same instructions in your puzzle input, what is the correct bathroom code?
-}

import Data.Map (Map, (!))
import qualified Data.Map as M
import Data.Char (intToDigit)

type Vec2 = (Int, Int)

keypad :: Map Vec2 Char
keypad = 
    let keypadStr = "  1   234 56789 ABC   D  "
    in M.fromList $ filter (\(_,c) -> c /= ' ') $ zip [(x,y) | y <- [-2..2], x <- [-2..2]] keypadStr

clamp :: Vec2 -> Vec2 -> Vec2
clamp (x,y) (dx,dy) = 
    let (x',y') = (x+dx,y+dy)
    in if M.member (x',y') keypad then (x', y') else (x,y)

go :: Vec2 -> Char -> Vec2
go coord 'U' = clamp coord (0,-1)
go coord 'D' = clamp coord (0,1)
go coord 'L' = clamp coord (-1,0)
go coord 'R' = clamp coord (1,0)

followSequence :: String -> Vec2
followSequence seq = foldl go (-2,0) seq

valAtSequence :: String -> Char
valAtSequence seq = keypad ! (followSequence seq)

main = do
    input <- readFile "2_1_input.txt"
    let seqs = lines input
    let code = map valAtSequence seqs
    print code