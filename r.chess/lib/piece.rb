load 'helpers'
load 'constants'

class Piece
  include Helpers
  attr_accessor :color, :unicode, :move_directions

  def initialize(color)
   @color = color
   @unicode = nil
   @move_directions = nil
  end
end

class Pawn < Piece
  def initialize(color)
    super
    @unicode = color == "white" ? WHITE_PAWN : BLACK_PAWN
  end

  def possible_moves(coords)
    
  end
end

class Rook < Piece
  attr_accessor :unicode

  def initialize(color)
    super
    @unicode = color == "white" ? WHITE_ROOK : BLACK_ROOK
  end

  def possible_moves(coords)
    
  end
end

class Knight < Piece
  def initialize(color)
    super
    @unicode = color == "white" ? WHITE_KNIGHT : BLACK_KNIGHT
  end

  def possible_moves(coords)
    
  end
end

class Bishop < Piece
  def initialize(color)
    super
    @unicode = color == "white" ? WHITE_BISHOP : BLACK_BISHOP
    @move_directions = ["up_left", "up_right", "down_left", "down_right"]
  end
end

class Queen < Piece
  def initialize(color)
    super
    @unicode = color == "white" ? WHITE_QUEEN : BLACK_QUEEN
  end

  def possible_moves(coords)
    
  end
end

class King < Piece
  def initialize(color)
    super
    @unicode = color == "white" ? WHITE_KING : BLACK_KING
  end

  def possible_moves(coords)
    
  end
end