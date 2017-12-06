$screen = {}
$screen_width = 50
$screen_height = 6

instructions = File.readlines("8_1_input.txt")

def print_screen()
	(0..$screen_height-1).each do |y|
		line = ""
		(0..$screen_width-1).each do |x|
			line += $screen[coord(x,y)] ? "#" : "."
		end
		puts line
	end
	puts
end

def coord(x,y)
	return "#{x},#{y}"
end

def rect(params)
	tokens = params[0].split("x")
	w,h = tokens[0].to_i, tokens[1].to_i
	(0..w-1).each do |x|
		(0..h-1).each do |y|
			$screen[coord(x,y)] = true
		end
	end
end

def set_or_clear(x, y, val)
	key = coord(x,y)
	if val
		$screen[key] = val
	else
		$screen.delete(key)
	end
end

def rotate(params)
	rotate_type = params[0]
	start = params[1].split("=")[1].to_i
	by = params.last.to_i

	(0..by-1).each do |i|
		last_screen = $screen.clone

		if rotate_type == "column"
			x = start
			(0..$screen_height-1).each do |y|
				set_or_clear(x,y,last_screen[coord(x,(y-1) % $screen_height)])
			end
		elsif rotate_type == "row"
			y = start
			(0..$screen_width-1).each do |x|
				set_or_clear(x,y,last_screen[coord((x-1) % $screen_width,y)])
			end
		end
	end
end

instructions.each do |instruction|
	tokens = instruction.rstrip.split
	command = tokens.first
	params = tokens[1..-1]

	case command
	when "rect"
		rect(params)
	when "rotate"
		rotate(params)
	end	

print_screen
end

puts $screen.to_a.count{|v| v[1]}