Light = Struct.new(:x, :y, :vx, :vy)
Bounds = Struct.new(:minx, :miny, :maxx, :maxy)

def print_lights(bounds, lights)
    filled = {}
    lights.each { |l| filled[[l.x,l.y]] = true }
    p ""
    (bounds.miny..bounds.maxy).each {|y|
        str = ""
        (bounds.minx..bounds.maxx).each {|x|
            str += "#{filled[[x,y]] ? "*" : "."} "
        }
        p str
    }
end

lights = File.readlines("input.txt").map { |line|
    px, py, vx, vy = line.match(/<(.*),(.*)>.*<(.*),(.*)>/)
        .to_a
        .drop(1)
        .map(&:to_i)
    Light.new(px, py, vx, vy)
}

max_height = 10
valid_height = false

1.step.each { |i|
    lights = lights.each { |l|
        l.x += l.vx
        l.y += l.vy
    }
    
    b = Bounds.new(Float::MAX, Float::MAX, Float::MIN, Float::MIN)
    lights.each { |l|
        b.minx = l.x if l.x < b.minx
        b.miny = l.y if l.y < b.miny
        b.maxx = l.x if l.x > b.maxx
        b.maxy = l.y if l.y > b.maxy
    }
    
    w, h = b.maxx - b.minx, b.maxy - b.miny
    if h > max_height 
        return if valid_height
        next
    end

    valid_height = true
    print_lights(b, lights)
    p i
}