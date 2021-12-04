def call_numbers(boards, num):
    last_winning_board = None
    for board in boards:
        if board[2] == True:
            continue
        board[0].discard(num)
        for winner in board[1]:
            winner.discard(num)
            if len(winner) == 0:
                board[2] = True
                last_winning_board = board
                break
    return last_winning_board

def board_row_winner(board_def, row):
    return set(board_def[row])

def board_col_winner(board_def, col):
    col_nums = set()
    for i in range(0,5):
        col_nums.add(board_def[i][col])
    return col_nums

def parse_board(data):
    board_def = [list(map(int,row.split())) for row in data.split('\n')]
    all_nums = set().union(*board_def)
    winners = [board_row_winner(board_def, row) for row in range(0,5)] + [board_col_winner(board_def, col) for col in range(0,5)]
    return [all_nums, winners, False]

groups = open('input.txt', 'r').read().split('\n\n')
calls = list(map(int,groups[0].split(',')))

boards = [parse_board(x) for x in groups[1:]]
num_boards = len(boards)
for num in calls:
    winner = call_numbers(boards, num)
    if winner:
        if all(board[2] == True for board in boards):
            unmarked_sum = sum(winner[0])
            print(unmarked_sum * num)
            break