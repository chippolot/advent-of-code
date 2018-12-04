=begin
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
=end

@dirs_4 = [[1,0], [0,-1], [-1,0], [0,1]]
@dirs_8 = [[1,0], [1,-1], [0,-1], [-1,-1], [-1,0], [-1,1], [0,1], [1,1]]

def pos_key(pos)
    return pos.join(',')
end

def spiral_directions()
    dirs = @dirs_4
    steps = 1.upto(Float::INFINITY).lazy
    return steps.zip(steps)
            .flat_map{|x| x}
            .zip(dirs.cycle)
            .flat_map{|times, dir| [dir] * times}
end

input = 347991
pos = [0,0]
grid = Hash.new(0)
grid[pos_key(pos)] = 1

spiral = spiral_directions()
spiral.each { |dx, dy|
    pos[0] += dx
    pos[1] += dy

    value = @dirs_8
            .map {|dx2, dy2| 
                new_pos = [pos[0] + dx2, pos[1] + dy2]
                grid[pos_key(new_pos)] 
            }
            .reduce(0, :+)

    if value > input
        puts value
        return
    end

    grid[pos_key(pos)] = value
}