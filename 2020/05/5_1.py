import math

def maxseat(seat_codes):
    max_seat_id = 0
    for code in seat_codes:
        row_min = 0
        row_max = 127
        col_min = 0
        col_max = 7
        for c in code:
            drows = row_max - row_min
            dcols = col_max - col_min
            if c == 'F':
                row_max -= drows/2
            elif c == 'B':
                row_min += math.ceil(drows/2)
            elif c == 'L':
                col_max -= dcols/2
            elif c == 'R':
                col_min += math.ceil(dcols/2)
        seat_id = row_min * 8 + col_min
        max_seat_id = max(max_seat_id, seat_id)
    return max_seat_id

lines = open('input.txt', 'r').read().splitlines()
found = maxseat(lines)
print(found)