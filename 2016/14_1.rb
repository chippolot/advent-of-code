require 'digest'

input = "qzyelonm"
$hash_map = {}

def get_hash(input, i)
	orig_hash = Digest::MD5.hexdigest("#{input}#{i}")
	if $hash_map[orig_hash]
		return $hash_map[orig_hash]
	end

	hash = orig_hash
	2016.times do
		hash = Digest::MD5.hexdigest(hash)
	end
	$hash_map[orig_hash] = hash
	return hash
end

i = -1
valid_hashes = []
while valid_hashes.length < 64 do
	i += 1
	hash = get_hash(input, i)
	
	triplet = hash.match(/(.)\1\1/)
	if triplet
		triplet_char = triplet[0][0]
		if (i+1..i+1001).any? { |j| get_hash(input, j).include?(triplet_char*5) }
			valid_hashes.push(hash)
			puts "VALID HASH at #{i} -- #{hash} -- #{valid_hashes.length}"
		end
	end
end