str = File.read("1_1_input.txt")
commands = str.split(", ")

x,y = 0,0	# start at 0,0
dx,dy = 0,1 # start facing north

visited = {}
visited["0,0"] = true

for command in commands
	turn_direction = command[0]
	paces = command[1..-1].to_i

	if turn_direction == "R"
		dx,dy = dy,-dx
	elsif turn_direction == "L"
		dx,dy = -dy,dx	
	end

	paces.times do |n|
		x,y = x+dx,y+dy

		coord = "#{x},#{y}"
		if visited[coord]
			puts "visited twice: #{coord}"
			puts "total blocks: #{x.abs+y.abs}"
			exit
		end
		visited[coord] = true
	end
end