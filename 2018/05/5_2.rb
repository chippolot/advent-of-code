=begin
Time to improve the polymer.

One of the unit types is causing problems; it's preventing the polymer from collapsing as much as it should. Your goal is to figure out which unit type is causing the most problems, remove all instances of it (regardless of polarity), fully react the remaining polymer, and measure its length.

For example, again using the polymer dabAcCaCBAcCcaDA from above:

Removing all A/a units produces dbcCCBcCcD. Fully reacting this polymer produces dbCBcD, which has length 6.
Removing all B/b units produces daAcCaCAcCcaDA. Fully reacting this polymer produces daCAcaDA, which has length 8.
Removing all C/c units produces dabAaBAaDA. Fully reacting this polymer produces daDA, which has length 4.
Removing all D/d units produces abAcCaCBAcCcaA. Fully reacting this polymer produces abCBAc, which has length 6.
In this example, removing all C/c units was best, producing the answer 4.

What is the length of the shortest polymer you can produce by removing all units of exactly one type and fully reacting the result?
=end

orig_polymer = File.read("input.txt")

def reacts(a, b)
    a != b && a.upcase == b.upcase
end

puts ('a'..'z').map { |unit|
    polymer = orig_polymer.tr(unit+unit.upcase, "")
    prev_length = polymer.length
    loop do
        polymer = polymer.chars.reduce("") { |str, c1|
            str += c1
            str.length < 2 || !reacts(str[-2], str[-1]) ? str : str[0..-3]
        }
        break if polymer.length == prev_length
        prev_length = polymer.length
    end
    polymer.length
}.min