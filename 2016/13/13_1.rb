$input = 1350
start_x, start_y = 1, 1
$goal_x, $goal_y = 31, 39

def draw_maze(w, h, path)
	path_map = {}
	if path
		node_iter = path
		while node_iter do
			path_map[node_iter[:coord]] = true
			node_iter = node_iter[:parent]
		end
	end

	puts "  "+(0..w-1).to_a.join
	(0..h-1).each do |y|
		line = "#{y}  "
		(0..w-1).each do |x|
			line += is_wall(x,y) ? "#" : path_map[coord(x,y)] ? "O" : "."
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

def get_heuristic(x, y)
	return ($goal_x - x)**2 + ($goal_y - y)**2
end

def make_node(parent, x, y)
	return { 
		parent: parent, 
		x:x, 
		y:y, 
		coord:coord(x,y), 
		distance_from_start:(parent ? parent[:distance_from_start] + 1 : 0), 
		heuristic:get_heuristic(x,y), 
		max_x:[x, (parent ? parent[:max_x]: 0)].max, 
		max_y:[y, (parent ? parent[:max_y]: 0)].max 
	}
end

def shortest_path(x1, y1, x2, y2)
	closed_set = {}
	open_set = [make_node(nil, x1, y1)]
	directions = [[1,0],[-1,0],[0,1],[0,-1]]

	# process all open nodes
	while open_set.length > 0 do
		node = open_set.shift
		closed_set[node[:coord]] = true

		# try all adjacent directions
		directions.each do |direction|
			dx, dy = direction
			tx, ty = node[:x] + dx, node[:y] + dy

			# make a new node
			t_node = make_node(node, tx, ty)
			if tx == $goal_x and ty == $goal_y
				return t_node
			end

			# skip walls and closed locations
			t_coord = t_node[:coord]
			if closed_set[t_coord] or is_wall(tx, ty)
				next
			end

			# is it in open set?
			open_idx = open_set.index{|v| v[:coord] == t_coord }
			if not open_idx
				open_set.push(t_node)
			else
				old_node = open_set[open_idx]
				if t_node[:distance_from_start] < old_node[:distance_from_start] 
					open_set[open_idx] = t_node
				end
			end
		end
	end
	return nil
end

path = shortest_path(start_x, start_y, $goal_x, $goal_y)

if path
	puts
	puts "PATH FOUND:"
	draw_maze(path[:max_x], path[:max_y], path)
	puts
	puts "DISTANCE: #{path[:distance_from_start]}"
else
	puts
	puts "NO PATH FOUND..."
end