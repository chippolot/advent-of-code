require 'set'

lines = File.readlines("input.txt")

grid = Hash.new(0)

overlaps = 0

lines.each do |line|
    matches = line.match(/#(\d*) @ (\d*),(\d*): (\d*)x(\d*)/).to_a.map(&:to_i)
    _, id, x, y, w, h = matches
    for i in x..(x+w-1) do
        for j in y..(y+h-1) do
            coord = i+j*1000
            grid[coord] += 1
            if grid[coord] == 2
                overlaps += 1
            end
        end
    end
end

puts overlaps