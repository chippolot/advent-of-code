require 'set'

lines = File.readlines("input.txt")

sum = 0
history = Set[0]

while true
    lines.each do |line|
        sum += line.to_i
        if history.add?(sum).nil?
            puts sum
            return
        end
    end
end