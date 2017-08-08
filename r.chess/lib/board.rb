class Board
  attr_reader :squares

  def initialize
    @squares = create_squares
  end

  def create_squares
    
  end

  def generate_square_coords
    xs = ["a", "b", "c", "d", "e", "f", "g", "h"]
    ys = [1, 2, 3, 4, 5, 6, 7, 8]
    squares = {}
   
    #generate hash of squares with their coordinates as values
    xs.each.with_index(1) do |x, i|
      ys.each do |y| 
        key = x.to_s + y.to_s
        val = [i, y]
        squares[key] = val
      end
    end
    squares
  end
end