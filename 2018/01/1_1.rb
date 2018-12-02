lines = File.readlines("input.txt")

sum = 0
lines.each do |line|
    sum += line.to_i
end

puts sum