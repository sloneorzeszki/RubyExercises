class Piece
  def initialize(type, color)
   @type = type
   @color = color
  end
end

class Rook < Piece
  def initialize
    super(type, color) 
  end

  def possible_moves(coords)
    
  end
end