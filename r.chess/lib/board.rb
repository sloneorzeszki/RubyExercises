require_relative 'piece'
require_relative 'helpers'

class Board
  include Helpers
  attr_accessor :squares

  def initialize
    @squares = create_squares
    create_pieces
  end

  def create_squares
    xs = ["a", "b", "c", "d", "e", "f", "g", "h"]
    ys = [1, 2, 3, 4, 5, 6, 7, 8]
    squares = {}
   
    #generate hash of squares with their coordinates as values
    xs.each.with_index(1) do |x, i|
      ys.each do |y| 
        key = x.to_s + y.to_s
        val = [i, y]
        squares[key.to_sym] = { coords: val, piece: nil }
      end
    end
    squares
  end

  def create_pieces
    create_pawns
    create_non_pawns
  end

    def create_pawns
      [["white", 2], ["black", 7]].each do |color, y| 
        (1..8).each { |x| @squares[to_key([x, y])][:piece] = Pawn.new(color) } 
      end
    end

    def create_non_pawns
      [["white", 1], ["black", 8]].each do |color, y| 
        [1, 8].each { |x| @squares[to_key([x, y])][:piece] = Rook.new(color) } 
        [2, 7].each { |x| @squares[to_key([x, y])][:piece] = Knight.new(color) } 
        [3, 6].each { |x| @squares[to_key([x, y])][:piece] = Bishop.new(color) } 
        [4].each    { |x| @squares[to_key([x, y])][:piece] = Queen.new(color) } 
        [5].each    { |x| @squares[to_key([x, y])][:piece] = King.new(color) } 
      end
    end


  def graphical_display
    p "   A B C D E F G H"
    p "   ---------------"
    (1..8).reverse_each do |y|
      row = "#{y} "
      ("a".."h").each do |x|
        row << " #{unicode(x+y.to_s)}"
      end
      row << "  #{y}"
      p row
    end
    p "   ---------------"
    p "   A B C D E F G H"
  end

  def unicode(address)
    piece = @squares[address.to_sym][:piece]
    piece.nil? ? "\u2610" : piece.unicode
  end
end