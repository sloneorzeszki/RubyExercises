class Board
  attr_reader :squares

  def initialize
    @squares = create_squares
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

  def graphical_display
    p "  A B C D E F G H"
    p "  ---------------"
    (1..8).each do |y|
      row = "#{y}"
      ("a".."h").each do |x|
        row << " #{unicode(x+y.to_s)}"
      end
      p row
    end
    p "  ---------------"
  end

  def unicode(add)
    piece = @squares[add.to_sym][:piece]
    piece.nil? ? "\u2610" : piece.unicode
  end
end