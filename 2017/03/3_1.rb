=begin
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
=end

def manhattan_dist(pos)
    return pos[0].abs + pos[1].abs
end

def spiral_directions(num_steps)
    dirs = [[1,0], [0,-1], [-1,0], [0,1]]
    steps = 1.upto(Float::INFINITY).lazy
    return steps.zip(steps)
            .flat_map{|x| x}
            .zip(dirs.cycle)
            .flat_map{|times, dir| [dir] * times}
            .take(num_steps)
end

input = 347991
pos = [0,0]

spiral = spiral_directions(input-1)
spiral.each { |dx, dy|
    pos[0] += dx
    pos[1] += dy
}
puts manhattan_dist(pos)