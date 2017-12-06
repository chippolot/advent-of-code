lines = File.readlines("9_1_input.txt")
length = 0
i = 0
lines.each do |line|
	line.rstrip!

	while line.length > 0 do

		i = i + 1
		if i % 10000 == 0
			puts "DECODING i=#{i} len=#{length} numparen=#{line.count("(")}"
		end

		tokens = line.partition(/(\(\w*\))/)

		# add length of on pre-string
		length += tokens[0].length

		# new line is everything after parens
		line = tokens[2]

		if tokens[1] != "" 
			repeat_instructions = tokens[1][1..-2].split("x")
			subseq_chars = repeat_instructions[0].to_i
			repeat_count = repeat_instructions[1].to_i
			line = line.slice!(0, subseq_chars) * repeat_count + line
		end
	end
	length += line.length
end
puts length