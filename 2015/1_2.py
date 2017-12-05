file = open("1_1_input.txt", "r")
str  = file.read()
level = 0
i = 0
for c in str:
	i = i + 1
	if c == "(":
		level = level + 1
	elif c == ")":
		level = level - 1
	if level == -1:
		print i
		break