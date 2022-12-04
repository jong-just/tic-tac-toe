# class for gameboard and it's methods
class GameBoard
  attr_accessor :board
  @@turns = 0

  def initialize(board)
    @board = board
  end

  # outputs the board, goes through the two levels of array
  def output_board
    for i in 0..2 do
      for j in 0..2 do
      print "#{@board[i][j]}"
      print " | " if j < 2
      end
      puts "\n---------" if i < 2
    end
  end

  def play(x, y, player)
    @board[x][y] = player
    self.output_board
    puts "\n\n"
    results = win_check(x, y, player)
    if results
      puts "#{results} wins!"
      return true
    end
  end

  def self.turn_count
    @@turns
  end

  private

  # game engine. Checks if anyone has won
  def win_check(x, y, player)
    @@turns+=1
    if @board[x][0] == @board[x][1] && @board[x][1] == @board[x][2] &&  @board[x][0] != " "# horiz check
      who_win(player)
    elsif @board[0][y] == @board[1][y] && @board[1][y] == @board[2][y] && @board[0][y] != " "# vert check
      who_win(player)
    elsif @board[0][0] == @board[1][1] && @board[1][1] == @board[2][2] && @board[1][1] != " "# diag check
      who_win(player)
    elsif @board[0][2] == @board[1][1] && @board[1][1] == @board[2][0] && @board[1][1] != " "# daig check two
      who_win(player)
    else
      return false
    end
  end

  def who_win(player)
    if player == "o" || player == "O"
      player
    elsif player == "x" || player == "X"
      player
    else
      puts "Something went wrong :("
    end
  end
end

class Player
  attr_reader :name
  attr_accessor :x_move, :y_move

  def initialize(name)
    @name = name
  end
end

board = GameBoard.new(Array.new(3) { Array.new(3, ' ') })
x = Player.new("x")
o = Player.new("o")

def start_game(x, o, board)
  end_game = false

  loop do
    puts GameBoard.turn_count
    if GameBoard.turn_count.to_i == 9
      puts "Tie game."
      break
    end
    end_game = one_round(x, o, board)
    if end_game
      break
    end
  end
end

def one_round(x, o, board)
  end_turn = true
  while end_turn do
    end_turn = player_move(x, board)
    if end_turn == "end game"
      return true
    end
  end

  if GameBoard.turn_count.to_i == 9
    return nil
  end

  end_turn = true

  while end_turn do
    end_turn = player_move(o, board)
    if end_turn == "end game"
      return true
    end
  end

  end_turn = true
  
  return false
end


def player_move(player, board)
  puts "#{player.name}'s turn"
  first_move = get_player_hand()
  input_validity = validify_hand(first_move)
  if input_validity == "break"
    puts "Goodbye"
    return "end game"
  elsif input_validity == true
    second_move = get_player_hand()
    input_validity = validify_hand(second_move)
    if input_validity == "break"
      puts "Goodbye"
      return "end game"
    elsif input_validity == false
      puts "Not a valid input"
      true
    elsif input_validity == true && board.board[first_move.to_i][second_move.to_i] != " "
      puts "Try again, that's already taken."
      true
    elsif input_validity == true
      game_end = board.play(first_move.to_i, second_move.to_i, player.name)
      print "\n"
      if game_end
        return "end game"
      end
      false
    end
  else
    puts "Not a valid input, please pick a number 0 to 2."
    true
  end
end

def get_player_hand()
  print "Input: "
  gets.chomp
end


def validify_hand(input)
  if input == "quit"
    "break"
  elsif input == ""
    false
  elsif input.upcase == input || input.downcase == input
    false
  elsif input.to_i.between?(0, 2)
    true
  else
    false
  end
end

start_game(x, o, board)
