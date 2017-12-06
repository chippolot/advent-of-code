ranges = File.readlines("20_1_input.txt").map{|line| 
	tokens = line.split("-").map(&:to_i)
	(tokens[0]..tokens[1])
}
ranges = ranges.sort_by(&:min)

last_allowed_ip = 0
num_ips_allowed = 0
max_ip = 10

ranges.each do |range|
	num_ips_allowed += [0, range.min - last_allowed_ip].max
	last_allowed_ip = [last_allowed_ip, range.max + 1].max
end
num_ips_allowed += [0, max_ip - (last_allowed_ip-1)].max

puts num_ips_allowed