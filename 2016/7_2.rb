file = File.open("7_1_input.txt", "r")

num_valid = 0

file.each_line do |line|
	ip_addr = line.rstrip

	#find ABA
	supernet = ip_addr.split(/\[\w*\]/).join(" ")
	supernet.scan(/(?=(\w)((?!\1)\w)\1)/) {|a,b| 

		# find corresponding BAB
		if ip_addr =~ /\[\w*#{b+a+b}\w*\]/
			num_valid += 1
			break
		end
	}
end

puts num_valid