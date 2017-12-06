$input = 1350
start_x, start_y = 1, 1
$max_steps = 50

def draw_maze(w, h, visited_set)
	puts "  "+(0..w-1).to_a.join
	(0..h-1).each do |y|
		line = "#{y}  "+(y<=9?" ":"")
		(0..w-1).each do |x|
			line += is_wall(x,y) ? "# " : visited_set[coord(x,y)] ? "O " : ". "
		end
		puts line
	end
end

def is_wall(x, y)
	return (x*x + 3*x + 2*x*y + y + y*y + $input).to_s(2).chars.count("1") % 2 == 1
end

def coord(x,y)
	return "#{x},#{y}"
end

def make_node(parent, x, y)
	return { 
		parent: parent, 
		x:x, 
		y:y, 
		coord:coord(x,y), 
		distance_from_start:(parent ? parent[:distance_from_start] + 1 : 0), 
		max_x:[x, (parent ? parent[:max_x]: 0)].max, 
		max_y:[y, (parent ? parent[:max_y]: 0)].max 
	}
end

def visit_maximum(x1, y1, x2, y2)
	visited_set = {}
	open_set = [make_node(nil, x1, y1)]
	directions = [[1,0],[-1,0],[0,1],[0,-1]]

	# process all open nodes
	while open_set.length > 0 do
		node = open_set.shift
		visited_set[node[:coord]] = true

		# try all adjacent directions
		directions.each do |direction|
			dx, dy = direction
			tx, ty = node[:x] + dx, node[:y] + dy
			if tx < 0 or ty < 0 
				next
			end

			# make a new node
			t_node = make_node(node, tx, ty)

			# skip walls and visited locations
			t_coord = t_node[:coord]
			if visited_set[t_coord] or is_wall(tx, ty)
				next
			end

			if t_node[:distance_from_start] == $max_steps
				visited_set[t_coord] = true
				next
			end

			# add to open set
			open_set.push(t_node)
		end
	end
	return visited_set
end

visited_set = visit_maximum(start_x, start_y, $goal_x, $goal_y)
draw_maze(50, 50, visited_set)
puts "VISITED #{visited_set.length} LOCATIONS"