lines = open('input.txt', 'r').read().splitlines()
earliest_time = int(lines[0])
busses = map(int,list(filter('x'.__ne__, lines[1].split(','))))

earliest_bus = None
earliest_wait = None
for bus in busses:
    rem = bus - (earliest_time % bus)
    if earliest_wait == None or rem < earliest_wait:
        earliest_wait = rem
        earliest_bus = bus
print(earliest_bus * earliest_wait)