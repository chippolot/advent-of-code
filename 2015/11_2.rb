def next_pass(pass)
    conditions_met = true
    begin
        pass.next!
        conditions_met = (0..pass.length-3).any?{|i| pass[i+2] == pass[i].next.next && pass[i+2] == pass[i+1].next}
        conditions_met = conditions_met && ['i','o','l'].none?{|c| pass.include?(c)}
        conditions_met = conditions_met && pass.scan(/([a-z])\1/).size >= 2
    end until conditions_met
    return pass
end
puts next_pass(next_pass("vzbxkghb"))