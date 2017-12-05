file = File.open("4_1_input.txt", "r")

def rotate_char(letter, num)
	letters = ('a'..'z').to_a
	idx = letters.find_index(letter)
	idx = (idx + num) % letters.length
	return letters[idx]
end

def is_valid_room_id(enc_name, sector_id, checksum)
	occurences = {}

	enc_name.each do |segment|
		segment.each_char do |c|
			occurences[c] = occurences.fetch(c, 0) + 1
		end
	end

	checksum_expected = occurences.to_a.sort{ |v1,v2| v1[1] == v2[1] ? v1[0] <=> v2[0] : v2[1] <=> v1[1] }.map{|v| v[0]}.take(5).join
	return checksum == checksum_expected
end

sum = 0

file.each_line do |line|
	t = line.split("[")
	checksum = t[1].rstrip[0..-2]

	t = t[0].split("-")
	enc_name = t[0..-2]
	sector_id = t.last.to_i

	if not is_valid_room_id(enc_name, sector_id, checksum)
		#next
	end

	decoded_name = enc_name.map{|v| v.chars.map{|c| rotate_char(c, sector_id)}.join}.join(" ")
	puts "#{decoded_name} #{sector_id}"
end