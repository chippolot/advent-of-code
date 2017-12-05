def volume(l, w, h):
	return l*w*h

def perimeter(w,h):
	return 2*w+2*h

file = open("2_1_input.txt", "r")

total_sqft = 0
for dimensions in file:
	l,w,h = dimensions.split("x")
	l = int(l)
	w = int(w)
	h = int(h)
	total_sqft = total_sqft + min(perimeter(l,w), perimeter(w,h), perimeter(l,h)) + volume(l,w,h)
print total_sqft