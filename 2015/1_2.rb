str = File.read("1_1_input.txt")
level = 0
i = 0
until level == -1 do
    level += str[i] == "(" ? 1 : -1
    i += 1
end
puts i