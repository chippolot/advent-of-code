{-
Then, you notice the instructions continue on the back of the Recruiting Document. Easter Bunny HQ is actually at the first location you visit twice.

For example, if your instructions are R8, R4, R4, R8, the first location you visit twice is 4 blocks away, due East.

How many blocks away is the first location you visit twice?
-}

import Data.List
import Data.List.Split

type Vec2 = (Int, Int)

rotate :: Char -> Vec2 -> Vec2
rotate 'R' (dx, dy) = (dy, -dx)
rotate 'L' (dx, dy) = (-dy, dx)

follow :: [String] -> [Vec2]
follow cmds = concat $ snd $ mapAccumL step ((0,0), (0,1)) cmds where
    step ((x,y), (dx,dy)) (dir:strSteps) = (((x', y'), (dx', dy')), lerpSteps) where
        (dx', dy') = rotate dir (dx, dy)
        steps = read strSteps :: Int
        (x', y') = (x + dx' * steps, y + dy' * steps)
        lerpSteps = [(x'', y'') | x'' <- if x /= x' then [x,x + (signum $ x' - x)..x' - (signum $ x' - x)] else [x], y'' <- if y /= y' then [y,y + (signum $ y' - y)..y' - (signum $ y' - y)] else [y]]

findFirstVisited :: [Vec2] -> Vec2
findFirstVisited locs = head $ locs \\ nub locs

main = do
    input <- readFile "1_1_input.txt"
    let cmds = splitOn ", " input
    let path = follow cmds
    let (x,y) = findFirstVisited path
    let dist = abs x + abs y
    print dist