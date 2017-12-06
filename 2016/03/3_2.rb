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

all_nums=[]

file.each_line do |line|
	all_nums[all_nums.length] = line.split.map(&:to_i)
end

(0..all_nums.length-1).step(3) do |row|
	(0..2).each do |col|
		num_valid += valid_triangle([all_nums[row][col],all_nums[row+1][col],all_nums[row+2][col]]) ? 1 : 0
	end
end


puts num_valid