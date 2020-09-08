class GameBoard
  WINNING_COMBOS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]

  def initialize
    @board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
  end

  def show_number_board
    puts "|-----------|"
    puts "| 7 | 8 | 9 |"
    puts "|-----------|"
    puts "| 4 | 5 | 6 |"
    puts "|-----------|"
    puts "| 1 | 2 | 3 |"
    puts "|-----------|"
  end

  def draw_board
    puts "|-----------|"
    puts "| #{@board[6]} | #{@board[7]} | #{@board[8]} |"
    puts "|-----------|"
    puts "| #{@board[3]} | #{@board[4]} | #{@board[5]} |"
    puts "|-----------|"
    puts "| #{@board[0]} | #{@board[1]} | #{@board[2]} |"
    puts "|-----------|"
  end

  def update_board(move, sign)
    @board[move] = sign
    self.draw_board
  end

  def get_position(move)
    return @board[move.to_i - 1]
  end

  def check_winner(move)
    current_player_moves = @board.each_index.select { |idx| @board[idx] == move} #=> [0,1,5]
    WINNING_COMBOS.each do |array|
      if array.all? { |n| current_player_moves.include? n }
        return true
      end
    end
    return false
  end
end


class Player
  attr_reader :name, :sign

  def initialize(name, sign)
    @name = name
    @sign = sign
  end

  def play_move(board, move)
    if board.get_position(move) == " "
      board.update_board(move.to_i - 1, self.sign)
      return 1
    else
      return nil
    end
  end
end


gameboard = GameBoard.new()

puts "Player 1: Enter your name..."
player_1 = Player.new(gets.chomp, "X")
puts "#{player_1.name}, you're playing as the 'X'"
puts "-------------------------------------------"

puts "Player 2: Enter your name..."
player_2 = Player.new(gets.chomp, "O")
puts "#{player_2.name}, you're playing as the 'O'"
puts "-------------------------------------------"

puts "Ok, let's start! The rules are simple: you both take turns marking the spaces in a 3×3 grid."
puts "The player who succeeds in placing three of their marks in a horizontal, vertical, or diagonal row is the winner!"
puts "Select your choice by typing the number of the corresponding cell you want to play:"
gameboard.show_number_board

9.times do |n|
  n % 2 == 0 ? current_player = player_1 : current_player = player_2
  completed_move = false
  until completed_move
    puts "#{current_player.name}, you're up! Where do you want to place your #{current_player.sign}?"
    input = gets.chomp
    if current_player.play_move(gameboard, input)
      if gameboard.check_winner(current_player.sign)
        puts "YES! #{current_player.name} WON!"
        exit
      end
      completed_move = true
    end
  end
end

puts "It's a draw! Nobody wins!"
