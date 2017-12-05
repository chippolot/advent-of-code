{-
As a stress test on the system, the programs here clear the grid and then store the value 1 in square 1. Then, in the same allocation order as shown above, they store the sum of the values in all adjacent squares, including diagonals.

So, the first few squares' values are chosen as follows:

Square 1 starts with the value 1.
Square 2 has only one adjacent filled square (with value 1), so it also stores 1.
Square 3 has both of the above squares as neighbors and stores the sum of their values, 2.
Square 4 has all three of the aforementioned squares as neighbors and stores the sum of their values, 4.
Square 5 only has the first and fourth squares as neighbors, so it gets the value 5.
Once a square is written, its value does not change. Therefore, the first few squares would receive the following values:

147  142  133  122   59
304    5    4    2   57
330   10    1    1   54
351   11   23   25   26
362  747  806--->   ...
What is the first value written that is larger than your puzzle input?
-}
import Data.List
import Data.Maybe
import qualified Data.Map.Strict as Map

type Coord = (Int, Int)

addCoords :: Coord -> Coord -> Coord
addCoords (x1,y1) (x2,y2) = (x1+x2, y1+y2)

directions :: [Coord]
directions = cycle [(1, 0), (0, 1), (-1, 0), (0, -1)]

neighbors :: Coord -> [Coord]
neighbors coord =
    let neighborsRelative = delete (0,0) [(x,y) | x <- [-1..1], y <- [-1..1]]
    in map (addCoords coord) neighborsRelative

spiralDirections :: [Coord]
spiralDirections = 
    let stepCounts = concat [[x,x] | x <- [1,2..]] -- 1,1,2,2,3,3,4,4,5,5..
        stepDirs = zipWith replicate stepCounts directions
    in concat stepDirs

spiralCoords :: [Coord]
spiralCoords = scanl1 addCoords spiralDirections

gridValues :: [Int]
gridValues = 
    let initialGridMap = Map.singleton (0,0) 1
        gridValueAt coord gridMap = sum $ map (\x -> Map.findWithDefault 0 x gridMap) (neighbors coord)
        step (gridMap, x:xs) = Just(s, (Map.insert x s gridMap, xs)) where s = gridValueAt x gridMap
    in unfoldr step (initialGridMap, spiralCoords)


main = do
    let input = 347991
    let answer = fromJust $ find (>input) gridValues
    print $ answer