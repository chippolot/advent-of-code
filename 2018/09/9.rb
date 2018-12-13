# Using an array to store the marbles was extremely slow due to the mid-list insertions and removals.
# A modified linked list is far more performant, especially for pt 2
class MarbleList
    class Node
        attr_accessor :next
        attr_accessor :prev
        attr_reader   :value

        def initialize(value)
        @value = value
        @next  = nil
        @prev = nil
        end
    end

    def initialize
        @head = nil
        @curr = nil
    end

    def counter_clockwise(by)
        by.times do 
            @curr = @curr.prev
        end
    end

    def clockwise(by)
        by.times do 
            @curr = @curr.next
        end
    end

    def insert(val)
        node = Node.new(val)
        if @curr
            @curr.next.prev = node if @curr.next
            node.prev = @curr
            node.next = @curr.next
            @curr.next = node
            @curr = node
        else
            @head = @curr = node
            @curr.next = @curr.prev = @curr
        end
    end

    def remove
        if @curr
            value = @curr.value
            @curr.next.prev = @curr.prev
            @curr.prev.next = @curr.next
            @curr = @curr.next
            return value
        end
        return 0
    end

    def to_s
        str = ""
        curr = @head
        loop do
            str += "#{curr.value} " if curr != @curr
            str += "(#{curr.value}) " if curr == @curr
            curr = curr.next
            break if curr == @head
        end
        return str
    end
end

def high_score(num_players, num_turns)
    marbles = MarbleList.new
    marbles.insert(0)
    scores = Array.new(num_players, 0)
    (1..num_turns).each { |turn|
        if turn % 23 == 0 
            scores[turn % scores.count] += turn
            marbles.counter_clockwise(7)
            scores[turn % scores.count] += marbles.remove()
        else
            marbles.clockwise(1)
            marbles.insert(turn)
        end
    }
    return scores.max
end

p high_score(411, 71058)
p high_score(411, 7105800)