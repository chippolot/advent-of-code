VERBOSE = false
DEBUG_MAX_DEPTH = nil

$objects = []
$num_floors = 4
$solution_node = nil
$tree = []
$checked_hashes = {}

def print_node(node)
	i = 0
	floor_strings = []
	node[:floors].each_slice($objects.length) do |floor|
		str = "F#{i} "
		str += node[:elevator] == i ? "E  " : ".  "
		str += floor.map { |v| v ? "#{v} " : ".  " }.join
		floor_strings.push(str)
		i += 1
	end
	puts floor_strings.reverse.join("\n")
	puts "---"*($objects.length+2)
end

def add_object(floors, object, floor_idx)
	object_idx = $objects.index(object)
	floors[floor_idx*$objects.length + object_idx] = object
end

def get_floor(floors, floor_idx)
	return floors[floor_idx * $objects.length, $objects.length]
end

def has_fried_microchip(node, floor_idx)
	floor = get_floor(node[:floors], floor_idx).compact
	pairs = floor.group_by {|v| v[0]}.values
	if pairs.any?{|v| v[0][1] == "G" } and pairs.any?{|v| v.length ==1 and v[0][1] == "M" }
		return true
	end
	return false
end

def is_valid_node(node)
	# if we've already checked this state, fail
	if $checked_hashes[node[:state_hash]]
		return false
	end

	# if the current or previous level contains a microchip and a generator, but they don't match, fail
	if has_fried_microchip(node, node[:elevator]) or (node[:parent] and has_fried_microchip(node, node[:parent][:elevator]))
		return false
	end

	# otherwise, valid
	return true
end

def new_floors_with_move(floors, group_to_move, from_floor_idx, to_floor_idx)
	floors = floors.clone
	group_to_move.each do |object|
		object_idx = $objects.index(object)
		floors[from_floor_idx*$objects.length+object_idx] = nil
		floors[to_floor_idx*$objects.length+object_idx] = object
	end
	return floors
end

def is_solution_node(node)
	top_floor = get_floor(node[:floors], $num_floors-1)
	return $objects.all? { |object| top_floor.include?(object) }
end

def add_node(parent, floors, elevator)
	state_hash = "#{elevator}#{floors.map {|object| object ? object : "."}.join}"

	depth = (parent ? parent[:depth]+1 : 0)
	new_node = { parent:parent, floors:floors, elevator:elevator, state_hash:state_hash, depth:depth}

	if not is_valid_node(new_node)
		return nil
	end

	if is_solution_node(new_node)
		$solution_node = new_node
	end

	if VERBOSE and depth > 0
		print_node(new_node)
	end
	$checked_hashes[new_node[:state_hash]] = true

	$tree[depth] ||= []
	$tree[depth].push(new_node)
	return new_node
end

def find_solution(tree_depth)
	puts "CHECKING_DEPTH #{tree_depth} WITH #{$tree[tree_depth].length} POSSIBILITIES"
	if VERBOSE
		puts "---"*$objects.length
	end

	$tree[tree_depth].each do |node|

		# collect all of the objects on the current elevator floor
		elevator = node[:elevator]
		floor = get_floor(node[:floors], elevator).compact

		# try moving in each direction
		[-1,1].each do |direction|

			# elevator moving out of range
			next_elevator = elevator + direction
			if not next_elevator.between?(0, $num_floors-1)
				next
			end

			# try moving all different groups
			combos = floor.combination(1).to_a
			combos.concat(floor.combination(2).to_a)
			(combos).each do |group|

				# create new node
				next_floors = new_floors_with_move(node[:floors], group, elevator, next_elevator)
				add_node(node, next_floors, next_elevator)

				# found solution
				if $solution_node
					return
				end
			end
		end
	end

	# recurse 1 level deeper
	tree_depth += 1
	if DEBUG_MAX_DEPTH and tree_depth > DEBUG_MAX_DEPTH
		puts "!!BREAKING DUE TO DEBUG MAX DEPTH REACHED #{tree_depth}"
		return
	end
	if $tree[tree_depth]
		find_solution(tree_depth)
	end
end

# sample input
=begin
$objects = ["HG","HM","LG","LM"]
floors = Array.new($objects.length * $num_floors, nil)
add_object(floors, "HG", 1)
add_object(floors, "HM", 0)
add_object(floors, "LG", 2)
add_object(floors, "LM", 0)
=end

# real input (part 1)
=begin
$objects = ["SG", "SM", "PG", "PM", "TG", "TM", "CG", "CM", "RG", "RM"]
floors = Array.new($objects.length * $num_floors, nil)
add_object(floors, "SG", 0)
add_object(floors, "SM", 0)
add_object(floors, "PG", 0)
add_object(floors, "PM", 0)
add_object(floors, "TG", 1)
add_object(floors, "RG", 1)
add_object(floors, "RM", 1)
add_object(floors, "CG", 1)
add_object(floors, "CM", 1)
add_object(floors, "TM", 2)
=end

# real input (part 2)
$objects = ["SG", "SM", "PG", "PM", "TG", "TM", "CG", "CM", "RG", "RM", "EG","EM","DG","DM"]
floors = Array.new($objects.length * $num_floors, nil)
add_object(floors, "SG", 0)
add_object(floors, "SM", 0)
add_object(floors, "PG", 0)
add_object(floors, "PM", 0)
add_object(floors, "EG", 0)
add_object(floors, "EM", 0)
add_object(floors, "DG", 0)
add_object(floors, "DM", 0)
add_object(floors, "TG", 1)
add_object(floors, "RG", 1)
add_object(floors, "RM", 1)
add_object(floors, "CG", 1)
add_object(floors, "CM", 1)
add_object(floors, "TM", 2)

root = add_node(nil, floors, 0)
puts
puts "START:"
print_node(root)

find_solution(0)
if $solution_node
	puts
	puts "SOLUTION:"
	print_node($solution_node)

	puts
	puts "NUM MOVES: #{$solution_node[:depth]}"
else
	puts
	puts "NO SOLUTION FOUND"
end
