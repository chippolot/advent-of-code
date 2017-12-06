file = File.open("6_1_input.txt","r")

letters = []
file.each_line do |line|
	letters.push(line.rstrip)
end

num_rows = letters.length
num_cols = letters[0].length

msg = ""

(0..num_cols-1).each do |col|
	occurrences = {}
	(0..num_rows-1).each do |row|
		c = letters[row][col]
		occurrences[c] = occurrences.fetch(c, 0) + 1
	end
	most_common_letter = occurrences.to_a.sort{|v1,v2| v2[1] <=> v1[1]}[0][0]
	msg += most_common_letter
end

puts msg