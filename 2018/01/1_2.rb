require 'set'

lines = File.readlines("input.txt")

sum = 0
history = Set[0]

lines.cycle do |line|
    sum += line.to_i
    if not history.add?(sum)
        puts sum
        return
    end
end