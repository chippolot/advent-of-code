def surface_area(l, w, h):
	return 2*l*w + 2*w*h + 2*h*l

def area(w,h):
	return w*h

file = open("2_1_input.txt", "r")

total_sqft = 0
for dimensions in file:
	l,w,h = dimensions.split("x")
	l = int(l)
	w = int(w)
	h = int(h)
	total_sqft = total_sqft + surface_area(l,w,h) + min(area(l,w), area(w,h), area(l,h))
print total_sqft