lines = File.read("input.txt").split("\n")
lines.combination(2) { |a, b|
    same = ""
    diffs = 0
    for i in 0..(a.length-1) do
        if a[i] != b[i] 
            diffs += 1
            break if diffs > 1
        else
            same += a[i]
        end
    end

    if diffs == 1
        puts same
        return
    end
}