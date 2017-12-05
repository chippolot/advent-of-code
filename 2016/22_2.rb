$DEBUG_MAX_DEPTH = nil
$VERBOSE = true

$tree = []
$width, $height = 0, 0

def coord(x,y)
	return "#{x},#{y}"
end

def print_grid(nodes_map)
	(0..$height-1).each do |y|
		line = ""
		(0..$width-1).each do |x|
			node = nodes_map[coord(x,y)]
			line += node[:has_goal_data] ? "G" : node[:is_wall] ? "#" : "."
			line += " "
		end
		puts line
	end
end

def get_possible_moves(nodes)
	return nodes.permutation(2).collect{ |combo|
		a,b = combo
		if a[:used] > 0 and b[:avail] >= a[:used]
			return combo
		else
			return nil
		end
	}
end

def mark_walls(nodes_map)
	nodes_map.each do |coord, node|
		x = node[:x]
		y = node[:y]
		node[:is_wall] = true
		(-1..1).each do |dx|
			(-1..1).each do |dy|

				# not a wall
				if not node[:is_wall]
					next
				end

				# don't check self
				if dx == 0 and dy == 0
					next
				end

				# out of bounds
				x2, y2 = x+dx, y+dy
				if x2 < 0 or x2 >= $width or y2 < 0 or y2 >= $height
					next
				end

				# if a neighboring node is large enough to accept out current data, we are not a wall
				if nodes_map[coord(x2,y2)][:size] >= node[:used]
					node[:is_wall] = false
				end
			end
		end
	end
end

# parse nodes and create list and map
nodes_list = File.readlines("22_1_input.txt")[2..-1].map{|line|  
	t = line.split
	t2 = t[0].split("-")
	node = { 	
		x:t2[1][1..-1].to_i,
		y:t2[2][1..-1].to_i,
		size: t[1][0..-2].to_i,
		used: t[2][0..-2].to_i,
		avail: t[3][0..-2].to_i
	}
	$width = [$width, node[:x]+1].max
	$height = [$height, node[:y]+1].max
	node
}
nodes_map = nodes_list.map {|node| [coord(node[:x], node[:y]), node]}.to_h

# set goal data flag
nodes_map[coord($width-1,0)][:has_goal_data] = true

# mark all walls so we don't waste time
# mark_walls(nodes_map)

if $VERBOSE
	print_grid(nodes_map)
end


