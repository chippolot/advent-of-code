=begin
On the other hand, if the coordinates are safe, maybe the best you can do is try to find a region near as many coordinates as possible.

For example, suppose you want the sum of the Manhattan distance to all of the coordinates to be less than 32. For each location, add up the distances to all of the given coordinates; if the total of those distances is less than 32, that location is within the desired region. Using the same coordinates as above, the resulting region looks like this:

..........
.A........
..........
...###..C.
..#D###...
..###E#...
.B.###....
..........
..........
........F.
In particular, consider the highlighted location 4,3 located at the top middle of the region. Its calculation is as follows, where abs() is the absolute value function:

Distance to coordinate A: abs(4-1) + abs(3-1) =  5
Distance to coordinate B: abs(4-1) + abs(3-6) =  6
Distance to coordinate C: abs(4-8) + abs(3-3) =  4
Distance to coordinate D: abs(4-3) + abs(3-4) =  2
Distance to coordinate E: abs(4-5) + abs(3-5) =  3
Distance to coordinate F: abs(4-8) + abs(3-9) = 10
Total distance: 5 + 6 + 4 + 2 + 3 + 10 = 30
Because the total distance to all coordinates (30) is less than 32, the location is within the region.

This region, which also includes coordinates D and E, has a total size of 16.

Your actual region will need to be much larger than this example, though, instead including all locations with a total distance of less than 10000.

What is the size of the region containing all locations which have a total distance to all given coordinates of less than 10000?
=end

def dist(a, b)
    (a[0] - b[0]).abs + (a[1] - b[1]).abs
end

def dist_from_all(pos, coords)
    coords.reduce(0){ |s, pos2| s + dist(pos, pos2) }
end

coords = File.readlines("input.txt").map { |x| x.split(', ').map(&:to_i) }

x0, y0 = coords[0]

center = coords.reduce([nil, nil]) { |(cx, cy), (x, y)| [(cx || 0) + x, (cy || 0) + y] }
center[0] /= coords.count
center[1] /= coords.count

max_dist = 10000
search_radius = 150 # increased number until area stopped increasing... cheating? you decide!

area = 0
for x in -search_radius..search_radius do
    for y in -search_radius..search_radius do
        area +=1 if dist_from_all([center[0] + x, center[1] + y], coords) < max_dist
    end
end

p area