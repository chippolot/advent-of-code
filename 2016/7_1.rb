file = File.open("7_1_input.txt", "r")

num_valid = 0

file.each_line do |line|
	ip_addr = line.rstrip

	# if we match any ABBA pairs inside square brackets, skip
	if ip_addr  =~ /\[\w*(\w)((?!\1)\w)\2\1\w*\]/
		next
	end

	# remove all square bracket scopes
	ip_addr = ip_addr.split(/\[\w*\]/).join(" ")

	# valid if we match any remaining ABBA pairs
	is_valid = ip_addr =~ /(\w)((?!\1)\w)\2\1/
	num_valid += is_valid ? 1 : 0
end

puts num_valid