def surface_area(l, w, h)
	return 2*l*w + 2*w*h + 2*h*l
end

def area(w,h)
	return w*h
end

total_sqft = 0
File.open("2_1_input.txt").each_line do |dimensions|
    l,w,h = dimensions.split("x").map(&:to_i)
    total_sqft +=  surface_area(l,w,h) + [area(l,w), area(w,h), area(l,h)].min
end
puts total_sqft