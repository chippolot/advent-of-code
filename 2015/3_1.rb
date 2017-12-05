str = File.read("3_1_input.txt")
directions = {'^'=>[0,1],'v'=>[0,-1],'<'=>[-1,0],'>'=>[1,0]}
x,y=0,0
deliveries={"0,0"=>1}

str.each_char do |c|
	t = directions[c]
	x,y=x+t[0],y+t[1]
    coord_str = "#{x},#{y}"
	deliveries[coord_str] = deliveries.fetch(coord_str, 0) + 1
end

puts deliveries.length