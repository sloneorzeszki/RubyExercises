class ConnectFour
  attr_accessor :board, :player1, :player2

  def initialize
    @board = Board.new
    @player1 = Player.new("player1","X")
    @player2 = Player.new("player2","O")    
  end

  def sequence(player)
    player_choice = player.choose_move
    board.mark_move(player_choice, player)
    board.display
    game_over(player) if board.solved?
  end

  def run
    @board.display
    loop do
      sequence(@player1)
      sequence(@player2)
    end
  end

  def game_over(player)
    puts "congratulations, " + player.name + "! You just won! That's soooo awesome!" 
    exit 
  end
end



class Board
  attr_accessor :board, :all

  def initialize
    @board = [['_','_','_','_','_','_','_'],['_','_','_','_','_','_','_'],['_','_','_','_','_','_','_'],['_','_','_','_','_','_','_'],['_','_','_','_','_','_','_'],['_','_','_','_','_','_','_']]
  end

  def display
    @board.each { |row|
      p row
    }
  end

  def column_has_space?(col_num)
    has_space=false
    @board.each { |row| 
      if row[col_num-1] == "_"
        has_space=true
      end
    }
    has_space    
  end

  def column_in_range?(col_num)
    if col_num.between?(1,7) 
      true
    else
      false
    end
  end

  def mark_move(player_choice, player)
      if !(column_has_space?(player_choice) && column_in_range?(player_choice))
	puts "Wrong column or column is full, please select another one"
	mark_move(player.choose_move,player)
      else
	@board.reverse_each { |row| 
	  if row[player_choice-1] == "_"
	    row[player_choice-1] = player.sign
	    break
	  else
	    next
	  end	
        }
      end		
  end
  
  def solved?
	(vertical_win? || horizontal_win?) || (diag_win?(1,3,6,3,5) || diag_win?(-1,0,3,3,5))
  end
	
  def horizontal_win?(board=@board)
   board.each do |row|
        row.each_cons(4) do |combination|
            if combination.join == "XXXX" || combination.join == "OOOO"
                return true
            end
        end
   end
   false
  end

  def vertical_win?
    horizontal_win?(@board.transpose)  
  end

  def diag_win?(way, col_start, col_end, row_start, row_end)
    all_combinations = []
	for col in col_start..col_end
        for row in row_start..row_end
            all_combinations << [@board[row][col],@board[row-1][col-1*way],@board[row-2][col-2*way],@board[row-3][col-3*way]].join
        end
    end
    return true if (all_combinations.include?("XXXX") || all_combinations.include?("OOOO"))
  end
end



class Player
  attr_accessor :name, :sign

  def initialize(player_name,sign)
    @name = player_name
    @sign = sign
  end

  def choose_move
    puts "#{name}, please select the column to put your mark on:"
    col_num = gets.chomp.to_i
  end
 end

game = ConnectFour.new
game.run