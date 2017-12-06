$new_tile_traps = {
	["^","^","."] => true,
	[".","^","^"] => true,
	[".",".","^"] => true,
	["^",".","."] => true
}

last_row = File.read("18_1_input.txt")
width = last_row.length
num_safe_tiles = last_row.chars.count{|v| v == "."}

def get_tile(row, idx)
	return idx < 0 ? "." : row[idx] || "."
end

def get_row(last_row)
	return last_row.length.times.map{|idx|
		tokens = [get_tile(last_row, idx-1), get_tile(last_row, idx), get_tile(last_row, idx+1)]
		
		$new_tile_traps[tokens] ? "^" : "."
	}.join
end

num_rows = 400000

puts last_row
(num_rows-1).times do |i|
	last_row = get_row(last_row)
	puts last_row
	num_safe_tiles += last_row.chars.count{|v| v == "."}
end

puts num_safe_tiles