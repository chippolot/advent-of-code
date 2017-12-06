file = File.open("2_1_input.txt", "r")

def clamp(num, min,max)
	num < min ? min : num > max ? max : num
end

numpad = [
	  	["-","-","1","-","-"],
	  	["-","2","3","4","-"],
		["5","6","7","8","9"],
		["-","A","B","C","-"],
	  	["-","-","D","-","-"]
]

x,y = 0,2

file.each_line do |line|
	line.each_char do |c|
		dx,dy = 0,0
		if c == "U"
			dy = -1
		elsif c == "D"
			dy = 1
		elsif c == "R"
			dx = 1
		elsif c == "L"
			dx = -1
		end

		x1,y1 = clamp(x+dx,0,4), clamp(y+dy,0,4)
		if numpad[y1][x1] != "-"
			x,y = x1,y1
		end
	end
	print numpad[y][x]
end
puts ""