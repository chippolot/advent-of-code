file = open('8_1_input.txt', 'r')

def count_newly_encoded_characters(str):
    return len(str) + str.count('\"') + str.count('\\') + 2

def count_string_literal_characters(str):
    return len(str)

def count_in_memory_characters(str):
    # slice double quotes
    str = str[1:-1]

    # unescape
    return len(str.decode('string_escape'))

total_string_literal_characters = 0
total_in_memory_characters = 0
total_newly_encoded_characters = 0

for line in file:
    str = line.rstrip()
    total_string_literal_characters += count_string_literal_characters(str)
    total_in_memory_characters += count_in_memory_characters(str)
    total_newly_encoded_characters += count_newly_encoded_characters(str)
print(total_newly_encoded_characters - total_string_literal_characters)