lines = File.readlines("input.txt")

twos = 0
threes = 0

lines.each do |line|
    counts = {}
    line.each_char do |char|
        counts[char] = (counts[char] or 0) + 1
    end
    twos += 1 if counts.value? 2
    threes += 1 if counts.value? 3
end

puts twos * threes