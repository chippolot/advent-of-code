# parse nodes
nodes = File.readlines("22_1_input.txt")[2..-1].map{|line|  
	t = line.split
	t2 = t[0].split("-")
	{ 	
		x:t2[1][1..-1].to_i,
		y:t2[2][1..-1].to_i,
		size: t[1][0..-2].to_i,
		used: t[2][0..-2].to_i,
		avail: t[3][0..-2].to_i
	}
}

puts nodes.permutation(2).count{ |combo|
	a,b = combo
	a[:used] > 0 and b[:avail] >= a[:used]
}