require 'set'

lines = File.readlines("input.txt")

grid = Hash.new
non_overlaps = Set.new

lines.each do |line|
    _, id, x, y, w, h =  line.match(/#(\d*) @ (\d*),(\d*): (\d*)x(\d*)/).to_a.map(&:to_i)

    no_overlaps = true
    for i in x..(x+w-1) do
        for j in y..(y+h-1) do
            coord = i+j*1000
            prev_claim = grid[coord]
            if not prev_claim
                grid[coord] = id
            else
                non_overlaps.delete(prev_claim)
                no_overlaps = false
            end
        end
    end

    if no_overlaps 
        non_overlaps.add(id)
    end
end

puts non_overlaps.first