str = File.read("3_1_input.txt")
directions = {'^'=>[0,1],'v'=>[0,-1],'<'=>[-1,0],'>'=>[1,0]}
coords = [[0,0],[0,0]]
deliveries={"0,0"=>2}

idx = 0
str.each_char do |c|
    t = directions[c]
    coords[idx][0],coords[idx][1]=coords[idx][0]+t[0],coords[idx][1]+t[1]
    coord_str = "#{coords[idx][0]},#{coords[idx][1]}"
    deliveries[coord_str] = deliveries.fetch(coord_str, 0) + 1
    idx = (idx + 1) % coords.length
end

puts deliveries.length