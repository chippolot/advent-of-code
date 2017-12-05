file = File.open("3_1_input.txt", "r")

def valid_triangle(sides)
	if sides[0] + sides[1] <= sides[2]
		return false
	elsif sides[1] + sides[2] <= sides[0]
		return false
	elsif sides[0] + sides[2] <= sides[1]
		return false
	end
	return true
end

num_valid = 0

file.each_line do |line|
	sides = line.split.map(&:to_i)
	if valid_triangle(sides)
		num_valid += 1
	end
end

puts num_valid