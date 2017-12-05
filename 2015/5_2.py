file = open("5_1_input.txt", "r")

nice = 0

def has_sandwiched_letter(string):
	i = 0
	while i < len(string) - 2:
		if string[i] == string[i+2]:
			return True
		i = i + 1

def has_non_overlapping_letter_pairs(string):
	i = 0
	while i < len(string) - 1:
		substr = string[i:i+2]
		if string.count(substr) >= 2:
			return True
		i = i + 1 


for string in file:
	if has_sandwiched_letter(string) and has_non_overlapping_letter_pairs(string):
		nice = nice + 1
print nice