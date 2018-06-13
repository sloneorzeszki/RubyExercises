require_relative 'helpers'

class Piece
  include Helpers
  attr_accessor :move_directions, :from

  def initialize(start_position)
   @from = to_coords(start_position) if start_position_allowed?(start_position)
   @move_directions = nil
  end

  def possible_moves
    allowed_moves = []
    @move_directions.each do |dir|
      x, y = @from.first, @from.last
      loop do
        new_move = [x+dir[0], y+dir[1]]
        if within_board?(to_addr(new_move))
          allowed_moves << new_move 
          x, y = new_move[0], new_move[1]
        else
          break
        end
      end
    end
    allowed_moves
  end

  def display_possible_moves
    moves = possible_moves
    moves.map! { |move| to_addr(move).to_s }
    puts moves.sort.to_s
  end
end

class King < Piece
  def initialize(start_position)
    super
    @move_directions = [[1,1], [-1,1], [-1,-1], [1,-1], [0,-1], [0,1], [1,0], [-1,0]]
    display_possible_moves
  end

  def possible_moves
    x, y = @from.first, @from.last
    moves = @move_directions.map { |move_dir| [x+move_dir[0], y+move_dir[1]] }
    moves.select! { |move| move if within_board?(to_addr(move)) }
    moves
  end
end

class Knight < Piece
  def initialize(start_position)
    super
    @move_directions = [[2,1], [2,-1], [1,2], [-1,2], [-2,1], [-2,-1], [1,-2], [-1,-2]]
    display_possible_moves
  end

  def possible_moves
    x, y = @from.first, @from.last
    moves = @move_directions.map { |move_dir| [x+move_dir[0], y+move_dir[1]] }
    moves.select! { |move| move if within_board?(to_addr(move)) }
    moves
  end
end

class Rook < Piece
  def initialize(start_position)
    super
    @move_directions = [[0,-1], [0, 1], [1, 0], [-1, 0]]
    display_possible_moves
  end
end

class Bishop < Piece
  def initialize(start_position)
    super
    @move_directions = [[1, 1], [-1, 1], [-1, -1], [1, -1]]
    display_possible_moves
  end
end

class Queen < Piece
  def initialize(start_position)
    super
    @move_directions = [[1, 1], [-1, 1], [-1, -1], [1, -1], [0, -1], [0, 1], [1, 0], [-1, 0]]
    display_possible_moves
  end
end
