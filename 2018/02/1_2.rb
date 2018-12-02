lines = File.read("input.txt").split("\n").sort
lines.combination(2) { |a, b|
    same = ""
    one_diff = false
    for i in 0..(a.length-1) do
        if a[i] != b[i] 
            if one_diff
                one_diff = false
                break
            end
            one_diff = true
        else
            same += a[i]
        end
    end

    if one_diff
        puts same
        return
    end
}