file = open("6_1_input.txt", "r")

lights = {}
w = 999
h = 999

TURN_ON = 1
TURN_OFF = 2,
TOGGLE = 3

command = None
start = None
end = None

def split_coords(coords):
	return [int(n) for n in coords.split(",")]

for line in file:
	tokens = line.split(" ")

	if line.startswith("turn on"):
		command = TURN_ON
		start = split_coords(tokens[2])
		end = split_coords(tokens[4])
	elif line.startswith("turn off"):
		command = TURN_OFF
		start = split_coords(tokens[2])
		end = split_coords(tokens[4])
	elif line.startswith("toggle"):
		command = TOGGLE
		start = split_coords(tokens[1])
		end = split_coords(tokens[3])

	for x in range(start[0],end[0]+1):
		for y in range(start[1],end[1]+1):
			light = lights.get((x,y),0)
			if command == TURN_ON:
				lights[(x,y)] = light + 1
			elif command == TURN_OFF:
				lights[(x,y)] = max(0, light - 1)
			elif command == TOGGLE:
				lights[(x,y)] = light + 2
print sum(lights.values())