input = "10010000000110000"
disk_size = 35651584

def get_checksum(data)
	loop do
		data = data.chars.each_slice(2).map { |slice| slice[0] == slice[1] ? "1" : "0"}.join
		puts "CHECKSUM LENGTH: #{data.length} is_odd? #{data.length % 2 == 1}"
		break if data.length % 2 == 1
	end
	return data
end

data = input
while data.length < disk_size do
	data = data + "0" + data.chars.reverse_each.map{|v| v == "0" ? "1" : "0" }.join
	puts "DATA LENGTH: #{data.length} <? #{disk_size}"
end

checksum = get_checksum(data[0,disk_size])
puts "CHECKSUM: #{checksum}"