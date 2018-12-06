=begin
The device on your wrist beeps several times, and once again you feel like you're falling.

"Situation critical," the device announces. "Destination indeterminate. Chronal interference detected. Please specify new target coordinates."

The device then produces a list of coordinates (your puzzle input). Are they places it thinks are safe or dangerous? It recommends you check manual page 729. The Elves did not give you a manual.

If they're dangerous, maybe you can minimize the danger by finding the coordinate that gives the largest distance from the other points.

Using only the Manhattan distance, determine the area around each coordinate by counting the number of integer X,Y locations that are closest to that coordinate (and aren't tied in distance to any other coordinate).

Your goal is to find the size of the largest area that isn't infinite. For example, consider the following list of coordinates:

1, 1
1, 6
8, 3
3, 4
5, 5
8, 9
If we name these coordinates A through F, we can draw them on a grid, putting 0,0 at the top left:

..........
.A........
..........
........C.
...D......
.....E....
.B........
..........
..........
........F.
This view is partial - the actual grid extends infinitely in all directions. Using the Manhattan distance, each location's closest coordinate can be determined, shown here in lowercase:

aaaaa.cccc
aAaaa.cccc
aaaddecccc
aadddeccCc
..dDdeeccc
bb.deEeecc
bBb.eeee..
bbb.eeefff
bbb.eeffff
bbb.ffffFf
Locations shown as . are equally far from two or more coordinates, and so they don't count as being closest to any.

In this example, the areas of coordinates A, B, C, and F are infinite - while not shown here, their areas extend forever outside the visible grid. However, the areas of coordinates D and E are finite: D is closest to 9 locations, and E is closest to 17 (both including the coordinate's location itself). Therefore, in this example, the size of the largest area is 17.

What is the size of the largest area that isn't infinite?
=end

require 'set'

def dist(a, b)
    (a[0] - b[0]).abs + (a[1] - b[1]).abs
end

def closest_id(pos, coords)
    dists = coords
        .each_with_index
        .map{|pos2, i| [i, dist(pos, pos2)] }
        .sort_by {|(i, dist)| dist }
    dists[0][1] < dists[1][1] ? dists[0][0] : -1
end

coords = File.readlines("input.txt").map { |x| x.split(', ').map(&:to_i) }

x0, y0 = coords[0]
bounds = coords.reduce([x0,y0,x0,y0]) { |(bx0, by0, bx1, by1), (x, y)|
    [[bx0, x].min, [by0, y].min, [bx1, x].max, [by1, y].max]
}

valid_areas = Hash.new(0)
coords.each_index { |i| valid_areas[i] = 0 }

for x in bounds[0]..bounds[2] do
    for y in bounds[1]..bounds[3] do
        pos = [x,y]
        closest = closest_id(pos, coords)
        is_infinite = (x == bounds[0] || x == bounds[2] || y == bounds[1] || y == bounds[3])
        if is_infinite
            valid_areas.delete(closest)
        elsif valid_areas.has_key?(closest)
            valid_areas[closest] += 1
        end
    end
end

p valid_areas.values.max