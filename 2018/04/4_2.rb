require 'date'

entries = File.readlines("input.txt")
            .map { |line|
                _, date_str, log = line.match(/\[(.*)\] (.*)/).to_a
                [DateTime.parse(date_str), log]
            }
            .sort { |a,b| a[0] <=> b[0] }

sleep_schedules = Array.new(60) { Hash.new{0} }
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
            schedule = sleep_schedules[min]
            schedule[curr_id] += 1
            sleep_schedules[min] = schedule
        end
    end
}

sleepiest_min = sleep_schedules.each_index.max_by {|i| sleep_schedules[i].values.max || 0 }
sleep_schedule = sleep_schedules[sleepiest_min]
sleepiest_id = sleep_schedule.key(sleep_schedule.values.max)

puts sleepiest_id * sleepiest_min