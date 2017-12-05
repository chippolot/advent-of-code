=begin
def ranges_overlap(a, b)
	return a.include? b.min or b.include? a.min
end

def merge_ranges(ranges)
	ranges = ranges.sort_by(&:min)

	merged_ranges = []

	return merged_ranges
end
=end

ranges = File.readlines("20_1_input.txt").map{|line| 
	tokens = line.split("-").map(&:to_i)
	(tokens[0]..tokens[1])
}
ranges = ranges.sort_by(&:min)

ip = 0
ranges.each do |range|
	if ip < range.min
		break
	end
	ip = range.max + 1
end

puts ip