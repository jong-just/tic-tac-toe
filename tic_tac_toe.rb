module BoardStructure
  def self.wall_row
    return "----------"
  end
end

class Board
  include BoardStructure

  def output_board(row_one, row_two, row_three)
    puts row_one
    puts BoardStructure.wall_row
    puts row_two
    puts BoardStructure.wall_row
    puts row_three
  end
end

# class for each playable rows. This wil be used to store and output rows
class Rows
  def initialize(a = " ", b = " ", c = " ")
    @a = a
    @b = b
    @c = c
  end

  def output_rows
    "#{@a} | #{@b} | #{@c}"
  end
end

row_one = Rows.new()
row_two = Rows.new()
row_three = Rows.new()

main_board = Board.new()
main_board.output_board(row_one.output_rows, row_two.output_rows, row_three.output_rows)