def volume(l, w, h)
    return l*w*h
end

def perimeter(w,h)
    return 2*w+2*h
end

total_sqft = 0
File.open("2_1_input.txt").each_line do |dimensions|
    l,w,h = dimensions.split("x").map(&:to_i)
    total_sqft +=  [perimeter(l,w), perimeter(w,h), perimeter(l,h)].min + volume(l,w,h)
end
puts total_sqft