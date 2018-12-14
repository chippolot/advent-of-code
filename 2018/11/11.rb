@serial = 3463

def get_power(x, y)
    rack_id = x + 10
    power = (rack_id * y + @serial) * rack_id
    power = (power / 100) % 10
    return power - 5
end

grid_size = 300
grid_range = (0..grid_size-1)

grid = Array.new(grid_size) { Array.new(grid_size, 0) }
grid_range.each {|x|
    grid_range.each {|y|
        grid[x][y] = get_power(x, y)
    }
}

max_sum = Float::MIN
best_coord = nil

grid_range.each {|x|
    grid_range.each {|y|
        sum = 0
        (0..2).each {|dx|
            next if x + dx >= grid_size
            (0..2).each {|dy|
                next if y + dy >= grid_size
                sum += grid[x+dx][y+dy]
            }
        }
        if not best_coord or sum > max_sum 
            max_sum = sum
            best_coord = [x, y]
        end
    }
}
p best_coord