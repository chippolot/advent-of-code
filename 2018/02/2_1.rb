lines = File.readlines("input.txt")

twos = 0
threes = 0

lines.each do |line|
    counts = Hash.new{0}
    line.each_char do |char|
        counts[char] += 1
    end
    twos += 1 if counts.value? 2
    threes += 1 if counts.value? 3
end

puts twos * threes