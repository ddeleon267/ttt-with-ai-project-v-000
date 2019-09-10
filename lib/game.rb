class Game

  attr_accessor :board, :player_1, :player_2, :input

  WIN_COMBINATIONS = [
    [0,1,2], # Top row
    [3,4,5], # Middle row
    [6,7,8], #bottom row
    [0,3,6], #left column
    [1,4,7], #middle column
    [2,5,8], #right column
    [2,4,6], #first diagonal
    [0,4,8] #second diagonal
  ]

  def initialize(player_1 = Players::Human.new("X"), player_2 = Players::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

  def current_player
    self.board.turn_count.odd? ? player_2 : player_1
  end

  def over?
    draw? || won?
  end
  
  def won?(board)
    
    WIN_COMBINATIONS.each do |combos|
  
      if combos[0] && combos[1] && combos[2] == "X"
        return combos
      elsif combos[0] && combos[1] && combos[2]  == "O"
        return combos
      else
        return false
      end
      
    end
  end

  def draw?
    self.board.full? && !won?
  end

  def winner
    board.cells[won?[0]] if won?

  end

  def turn
    puts "Please enter 1-9:"
    input = self.current_player.move(board)
    if board.valid_move?(input)
      board.update(input, self.current_player)
      board.display
    else
      turn #unless over?
    end
  end

  def play
    turn until over?
    puts "Congratulations #{winner}!" if won?
    puts "Cat's Game!" if draw?
  end
end
