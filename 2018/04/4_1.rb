require 'date'

entries = File.readlines("input.txt")
            .map { |line|
                _, date_str, log = line.match(/\[(.*)\] (.*)/).to_a
                [DateTime.parse(date_str), log]
            }
            .sort { |a,b| a[0] <=> b[0] }

sleep_schedules = Hash.new { Array.new(60, 0) }
curr_id, sleep_start = nil, nil

entries.each {|entry|
    timestamp, log = entry
    if log.start_with? "Guard"
        _, curr_id = log.match(/#(\d*)/).to_a
        curr_id = curr_id.to_i
    elsif log.start_with? "falls"
        sleep_start = timestamp
    elsif log.start_with? "wakes"
        for min in sleep_start.minute..(timestamp.minute-1) do
            schedule = sleep_schedules[curr_id]
            schedule[min] += 1
            sleep_schedules[curr_id] = schedule
        end
    end
}

sleepiest_id, sleepiest_schedule = sleep_schedules.max_by { |k,v| v.reduce(0, :+) }
sleepiest_min = sleepiest_schedule.index(sleepiest_schedule.max)

puts sleepiest_id * sleepiest_min