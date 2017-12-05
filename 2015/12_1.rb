require 'json'
require 'pp'

$sum = 0

def sum_numbers(json)
	pp json
	json.each do |v|
		if v.is_a?(Hash) || v.is_a?(Array)
			sum_numbers(v)
		elsif v.is_a?(Numeric)
			$sum += v
		end
	end
end

str = File.read("12_1_input.txt")
json = JSON.parse("[[[{'r':3}]]]")
sum_numbers(json)
puts $sum