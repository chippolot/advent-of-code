require 'digest'

$direction_chars = {
	[1,0] => "R",
	[-1,0] => "L",
	[0,-1] => "U",
	[0,1] => "D"
}
$directions = [[0,-1],[0,1],[-1,0],[1,0]]

def get_heuristic(x, y, goal_x, goal_y)
	return (goal_x - x)**2 + (goal_y - y)**2
end

def make_node(parent, x, y, goal_x, goal_y)
	node = { 
		parent: parent, 
		x:x, 
		y:y, 
		path:"", 
		heuristic:get_heuristic(x,y, goal_x, goal_y)
	}
	if parent
		dx, dy = x - parent[:x], y - parent[:y]
		node[:path] = parent[:path] + $direction_chars[[dx, dy]]
		#puts "TRYING #{node[:path]}"
	end
	return node
end

def get_allowed_directions(node,password)
	allowed_directions = []
	hash = Digest::MD5.hexdigest("#{password}#{node[:path]}")
	(0..$directions.length-1).each do |i|
		if ('b'..'f').include?(hash[i])
			allowed_directions.push($directions[i])
		end
	end
	return allowed_directions
end

def longest_path(x1, y1, x2, y2, maze_width, maze_height, password)
	open_set = [make_node(nil, x1, y1, x2, y2)]
	longest_path = nil

	# process all open nodes
	while open_set.length > 0 do
		open_set.sort! { |v1, v2| v2[:path].length <=> v1[:path].length }
		node = open_set.shift

		# try all adjacent directions
		directions = get_allowed_directions(node, password)
		directions.each do |direction|
			dx, dy = direction
			tx, ty = node[:x] + dx, node[:y] + dy

			#out of bounds
			if tx < 0 or tx >= maze_width or ty < 0 or ty >= maze_height
				next
			end

			# make a new node
			t_node = make_node(node, tx, ty, x2, y2)
			if tx == x2 and ty == y2
				path = t_node[:path]
				longest_path ||= path
				if path.length > longest_path.length
					longest_path = path
				end
				next
			end

			# add to open
			open_set.push(t_node)
		end
	end
	return longest_path ?  "#{longest_path.length} #{longest_path}" : "NO PATH FOUND"
end

puts longest_path(0,0,3,3,4,4,"hhhxzeay")