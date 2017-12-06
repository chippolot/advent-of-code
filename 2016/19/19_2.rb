$VERBOSE = true

num_elves = 3014387
elves = []
num_elves.times do |idx|
	elves[idx] = [1, idx+1]
end

def pass_presents(elves)
	num_elves = elves.length

	idx = 0
	i = 0
	loop do
		next_idx = (idx + (elves.length/2).floor) % elves.length

		if $VERBOSE
			if i % 100 == 0
				puts "#{elves[idx][1]} <- #{elves[next_idx][1]} = #{elves.length}"
			end
			i += 1
		end

		elves[idx][0] += elves[next_idx][0]
		elves.delete_at(next_idx)
		if next_idx < idx
			idx -= 1
		end

		if elves.length == 1
			return elves[idx][1]
		end

		idx = (idx + 1) % elves.length
	end
end

puts pass_presents(elves)