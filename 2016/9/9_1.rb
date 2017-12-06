lines = File.readlines("9_1_input.txt")
length = 0
lines.each do |line|
	line.rstrip!
	decompressed_line = ""

	while line.length > 0 do
		if line[0] == "("
			tokens = line.partition(/(\(\w*\))/)
			repeat_instructions = tokens[1][1..-2].split("x")
			subseq_chars = repeat_instructions[0].to_i
			repeat_count = repeat_instructions[1].to_i
			line = tokens[2]

			decompressed_line += line.slice!(0, subseq_chars) * repeat_count
		else
			decompressed_line += line.slice!(0)
		end	
	end

	length += decompressed_line.length
	puts decompressed_line
end
puts length