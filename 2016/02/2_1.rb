file = File.open("2_1_input.txt", "r")

def clamp(num, min,max)
	num < min ? min : num > max ? max : num
end

x,y = 1,1

file.each_line do |line|
	line.each_char do |c|
		dx,dy = 0,0
		if c == "U"
			dy = -1
		elsif c == "D"
			dy = 1
		elsif c == "R"
			dx = 1
		elsif c == "L"
			dx = -1
		end

		x,y = clamp(x+dx,0,2), clamp(y+dy,0,2)
	end
	print "#{y*3+x+1}" 	# number
end
puts ""