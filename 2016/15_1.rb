discs = [[0,7], [0,13], [2,3], [2,5], [0,17], [7,19],[0,11]]
#discs = [[4,5],[1,2]]

i = 0
while true do
	if (0..discs.length-1).all? {|j| (discs[j][0] + i + j + 1) % discs[j][1] == 0 }
		break
	end
	i += 1
end

puts i