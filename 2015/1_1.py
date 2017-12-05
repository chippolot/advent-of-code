file = open("1_1_input.txt", "r")
str  = file.read()
print(str.count("(") - str.count(")"))