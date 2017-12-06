instructions = File.readlines("10_1_input.txt")

$bots = {}
$bot_instructions = {}
$outputs = {}

def try_process_bot_instruction(bot_id)
	if not $bots[bot_id] or $bots[bot_id].length < 2 or not $bot_instructions[bot_id]
		return
	end
	tokens = $bot_instructions[bot_id]
	puts "bot #{bot_id} is comparing #{$bots[bot_id]}"
	give_to_target(bot_id, 0, tokens[5], tokens[6].to_i)
	give_to_target(bot_id, 1, tokens[10], tokens[11].to_i)
	$bots.delete(bot_id)
end

def give_to_bot(chip, bot_id)
	$bots[bot_id] = $bots.fetch(bot_id, []).push(chip).sort
	try_process_bot_instruction(bot_id)
end

def give_to_target(bot_id, chip_index, target_type, target_id)
	chip = $bots[bot_id][chip_index]
	if target_type == "output"
		$outputs[target_id] = chip
	else
		give_to_bot(chip, target_id)
	end
end

instructions.sort!{|i1, i2| i2 <=> i1}
instructions.each do |instruction|

	# parse instruction
	tokens = instruction.rstrip.split
	target_id = tokens.last.to_i

	# take chip
	if tokens[0] == "value"
		give_to_bot(tokens[1].to_i, target_id)

	# save instruction
	else
		bot_id = tokens[1].to_i
		$bot_instructions[bot_id] = tokens
		try_process_bot_instruction(bot_id)
	end 
end

puts $outputs
puts $outputs[0] * $outputs[1] * $outputs[2]