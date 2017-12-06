{-
Santa's sleigh uses a very high-precision clock to guide its movements, and the clock's oscillator is regulated by stars. Unfortunately, the stars have been stolen... by the Easter Bunny. To save Christmas, Santa needs you to retrieve all fifty stars by December 25th.

Collect stars by solving puzzles. Two puzzles will be made available on each day in the advent calendar; the second puzzle is unlocked when you complete the first. Each puzzle grants one star. Good luck!

You're airdropped near Easter Bunny Headquarters in a city somewhere. "Near", unfortunately, is as close as you can get - the instructions on the Easter Bunny Recruiting Document the Elves intercepted start here, and nobody had time to work them out further.

The Document indicates that you should start at the given coordinates (where you just landed) and face North. Then, follow the provided sequence: either turn left (L) or right (R) 90 degrees, then walk forward the given number of blocks, ending at a new intersection.

There's no time to follow such ridiculous instructions on foot, though, so you take a moment and work out the destination. Given that you can only walk on the street grid of the city, how far is the shortest path to the destination?

For example:

Following R2, L3 leaves you 2 blocks East and 3 blocks North, or 5 blocks away.
R2, R2, R2 leaves you 2 blocks due South of your starting position, which is 2 blocks away.
R5, L5, R5, R3 leaves you 12 blocks away.
-}

import Data.List.Split

type Vec2 = (Int, Int)

-- (x,y), (dirX,dirY)
type MoveState = (Vec2, Vec2)

rotate :: Char -> Vec2 -> Vec2
rotate 'R' (dx, dy) = (dy, -dx)
rotate 'L' (dx, dy) = (-dy, dx)

follow :: [String] -> MoveState
follow cmds = foldl step ((0,0), (0,1)) cmds where
    step ((x,y),(dx,dy)) (dir:strSteps) = ((x + dx' * steps, y + dy' * steps), (dx', dy')) where
        (dx', dy') = rotate dir (dx, dy)
        steps = read strSteps :: Int

main = do
    input <- readFile "1_1_input.txt"
    let cmds = splitOn ", " input
    let ((x,y),_) = follow cmds
    let dist = abs x + abs y
    print dist