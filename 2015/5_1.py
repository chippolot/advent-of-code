file = open("5_1_input.txt", "r")

nice = 0
vowels=['a','e','i','o','u']
bad_strings=['ab','cd','pq','xy']

def has_double_letters(string):
	i = 0
	while i < len(string) - 1:
		if string[i] == string[i+1]:
			return True
		i = i + 1


for string in file:
	has_vowel = sum(ch in vowels for ch in string) >= 3
	has_double_letter = has_double_letters(string)
	has_bad_string = any(bad_string in string for bad_string in bad_strings)
	if has_vowel and has_double_letter and not has_bad_string:
		nice = nice + 1
print nice