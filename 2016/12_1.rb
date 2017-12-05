$instructions = File.readlines("12_1_input.txt").map {|v| v.split}
$registers = {"a"=>0,"b"=>0,"c"=>1,"d"=>0}

def get_value(param)
	# is integer
	if param.to_i.to_s == param
		return param.to_i
	else
		return $registers[param]
	end
end

def execute_instruction(instruction_idx)
	command, param1, param2 = $instructions[instruction_idx]

	case command
	when "cpy"
		$registers[param2] = get_value(param1)
	when "inc"
		$registers[param1] += 1
	when "dec"
		$registers[param1] -= 1
	when "jnz"
		if get_value(param1) != 0
			return instruction_idx + param2.to_i
		end
	end

	return instruction_idx + 1
end

instruction_idx = 0
while instruction_idx < $instructions.length do
	instruction_idx = execute_instruction(instruction_idx)
end

puts "Final Registers: #{$registers}"