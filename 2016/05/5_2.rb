require 'digest'

door_id = "ojvtpuvg"
idx = 0
password = "________"

valid_indices = {}
(0..7).each do |i|
	valid_indices[i.to_s] = true
end

while password.include? "_" do
	hash = Digest::MD5.hexdigest("#{door_id}#{idx}")
	if hash[0..4] == "00000"
		hash_idx = hash[5]
		if valid_indices[hash_idx] and password[hash_idx.to_i] == "_"
			password[hash_idx.to_i] = hash[6]
			puts password
		end
	end
	idx += 1
end

puts password