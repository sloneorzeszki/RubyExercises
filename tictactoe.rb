module Helpers
  def ask_for_names
    puts "Enter the name of the first player:"
    player1_name = gets.chomp
    puts "Enter the name of the second player:"
    player2_name = gets.chomp
    names = [player1_name, player2_name]
    return names
  end
end


class TicTacToe
  include Helpers
  
  attr_accessor :player1, :player2, :board

  def initialize
    names = ask_for_names
    @player1 = Player.new(names[0], "X")
    @player2 = Player.new(names[1], "O")
    @board = Board.new
  end
  
  def sequence(player)
    player_choice = player.choose_move
    board.mark_move(player_choice, player)
    board.display
    board.solved?(player)
  end
  
  def run
    @board.display
    loop do
      sequence(@player1)
      sequence(@player2)
    end
  end
end


class Player
  attr_accessor :name, :sign
  
  def initialize(name, sign)
    @name = name
    @sign = sign
  end
  
  def choose_move	
    row = select_value("row")
    column = select_value("column")
    choice = [row-1, column-1]
    return choice
  end
  
  def select_value(value_name)
    valid_value = false
    puts "#{name}, please select the #{value_name} to put your mark:"	
    until valid_value
      val = gets.chomp.to_i
      if val.between?(1,3) 
        valid_value = true 
      else
        puts "Value must be between 1 and 3."
      end
      val
    end
    val
  end
end

class Board
  attr_accessor :board
  
  def initialize
    @board = [ 
            ["_","_","_"],
            ["_","_","_"],
            ["_","_","_"]
            ]
  end
  
  def mark_move(player_choice, player)
    r = player_choice[0]
    c = player_choice[1]
    
    if @board[r][c] != "X" && @board[r][c] != "O"
      @board[r][c] = player.sign.to_s
    else
      puts "Position already taken."
      mark_move(player.choose_move, player)
    end
  end
  
  def display
      @board.each{|x| puts x.join(" | ") }
  end
  
  def solved?(player)
    game_solved = false
    found_dash = false
	
	  catch :game_over do
      #solved horizontally
      @board.each do |x| 
        if x.all?{|y| y == "X"} || x.all?{|y| y == "O"}
          game_solved = true
        end
        throw :game_over if game_solved
      end
		
      #solved vertically
      for i in 0..2
        column = []
        
        @board.each do |x|
          column << x[i]
        end
        game_solved = column.all?{|y| y == "X"} || column.all?{|y| y == "O"}
        
       throw :game_over if game_solved
      end
      
      #solved diagonally
      middle = @board[1][1]
      if middle == "X" || middle == "O"
        if (@board[0][0] == middle && @board[2][2] == middle) || (@board[0][2] == middle && @board[2][0] == middle) 
          game_solved = true
        end
      end
      
      #draw
      if game_solved == false
        catch :not_draw do
          @board.each do|first_lvl| 
            first_lvl.each do |second_lvl| 
              if second_lvl == "_"
                found_dash = true
              end
              throw :not_draw if found_dash == true
            end
          end
        end
        found_dash
      end
	  end
	  
    if game_solved
      puts "PLAYER #{player.name.upcase} WON!!!" 
      exit
    elsif found_dash == false
      puts "DRAW!!!" 
      exit
    end
  end
end

game = TicTacToe.new
game.run
