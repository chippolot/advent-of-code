require 'digest'

door_id = "ojvtpuvg"
idx = 0
password = ""

while password.length < 8 do
	hash = Digest::MD5.hexdigest("#{door_id}#{idx}")
	if hash[0..4] == "00000"
		password += hash[5]
	end
	idx += 1
end

puts password