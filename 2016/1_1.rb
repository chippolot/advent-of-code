str = File.read("1_1_input.txt")
commands = str.split(", ")

x,y = 0,0	# start at 0,0
dx,dy = 0,1 # start facing north

for command in commands
	turn_direction = command[0]
	paces = command[1..-1].to_i

	if turn_direction == "R"
		dx,dy = dy,-dx
	elsif turn_direction == "L"
		dx,dy = -dy,dx	
	end

	x += dx*paces
	y += dy*paces
end

puts "final: #{x},#{y}"
puts "total blocks: #{x.abs + y.abs}"