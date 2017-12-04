{-
You come across an experimental new kind of memory stored on an infinite two-dimensional grid.

Each square on the grid is allocated in a spiral pattern starting at a location marked 1 and then counting up while spiraling outward. For example, the first few squares are allocated like this:

17  16  15  14  13
18   5   4   3  12
19   6   1   2  11
20   7   8   9  10
21  22  23---> ...
While this is very space-efficient (no squares are skipped), requested data must be carried back to square 1 (the location of the only access port for this memory system) by programs that can only move up, down, left, or right. They always take the shortest path: the Manhattan Distance between the location of the data and square 1.

For example:

Data from square 1 is carried 0 steps, since it's at the access port.
Data from square 12 is carried 3 steps, such as: down, left, left.
Data from square 23 is carried only 2 steps: up twice.
Data from square 1024 must be carried 31 steps.
How many steps are required to carry the data from the square identified in your puzzle input all the way to the access port?
-}
import Data.List

type Coord = (Int, Int)

addCoords :: Coord -> Coord -> Coord
addCoords (x1,y1) (x2,y2) = (x1+x2, y1+y2)

directions :: [Coord]
directions = cycle [(1, 0), (0, 1), (-1, 0), (0, -1)]

spiralDirections :: [Coord]
spiralDirections = 
    let stepCounts = concat [[x,x] | x <- [1,2..]] -- 1,1,2,2,3,3,4,4,5,5..
        stepDirs = zipWith replicate stepCounts directions
    in concat stepDirs

coordAtSteps :: Int -> Coord
coordAtSteps num = foldl1 addCoords $ take num spiralDirections

main = do
    let input = 347991
    let steps = input - 1
    let (x,y) = coordAtSteps steps
    print $ abs x + abs y