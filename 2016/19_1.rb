$VERBOSE = true

num_elves = 3014387
elves = Array.new(num_elves,1)

def get_next_idx(idx, elves)
	loop do
		idx = (idx + 1) % elves.length
		if elves[idx] > 0 
			return idx
		end
	end
end

def pass_presents(elves)

	idx = 0
	i = 0
	loop do
		next_idx = get_next_idx(idx, elves)

		if $VERBOSE
			if i % 100 == 0
				puts "#{idx+1} <- #{next_idx+1} = #{elves.length - i}"
			end
			i += 1
		end

		elves[idx] += elves[next_idx]
		elves[next_idx] = 0
		if elves[idx] == elves.length
			return idx + 1
		end

		idx = get_next_idx(idx, elves)
	end
end

puts pass_presents(elves)