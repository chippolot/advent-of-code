instructions = File.readlines("21_1_input.txt")

str = "fbgdceah"

$rotate_by_lookup = {}
(0..str.length-1).each do |i|
	c = str[i]
	rot = 1 + i + (i >= 4 ? 1 : 0)
	idx = -rot % str.length
	i2 = (str[idx..-1]+str[0,idx]).index(c)
	$rotate_by_lookup[i2] = i
end
print $rotate_by_lookup
puts 

def swap(str, tokens)
	idx1, idx2 = 0, 0
	if tokens[1] == "position"
		idx1, idx2 = tokens[2].to_i, tokens[5].to_i
	else
		c1, c2 = tokens[2], tokens[5]
		idx1, idx2 = str.index(c1), str.index(c2)
	end
	str[idx1], str[idx2] = str[idx2], str[idx1]
	return str
end

def rotate(str, tokens)
	rotate_num = 0
	if tokens[1] == "based"
		idx = str.index(tokens[6])
		idx2 = $rotate_by_lookup[idx]
		rotate_num = -((idx2 - idx) % str.length)
	else
		rotate_num = tokens[2].to_i * (tokens[1] == "left" ? -1 : 1)
	end
	idx = rotate_num % str.length
	str = str[idx..-1]+str[0,idx]
	return str
end

def reverse(str, tokens)
	idx1, idx2 = tokens[2].to_i, tokens[4].to_i
	return str[0,idx1]+str[idx1..idx2].reverse+str[idx2+1..-1]
end

def move(str, tokens)
	idx = tokens[5].to_i
	c, str[idx] = str[idx], ""
	return str.insert(tokens[2].to_i, c)
end

puts str
instructions.map(&:split).reverse_each do |tokens|
	case tokens[0]
		when "swap"
			str = swap(str, tokens)
		when "rotate"
			str = rotate(str, tokens)
		when "reverse"
			str = reverse(str, tokens)
		when "move"
			str = move(str, tokens)
	end
	puts str
end