class Board
  attr_reader :board

  def initialize
    @board = create_board
  end

  def create_board
    xs = ["a", "b", "c", "d", "e", "f", "g", "h"]
    ys = [1, 2, 3, 4, 5, 6, 7, 8]
    board = {}
   
    #generate hash of squares with their coordinates as values
    xs.each.with_index(1) do |x, i|
      ys.each do |y| 
        key = x.to_s + y.to_s
        val = [i, y]
        board[key] = val
      end
    end
    board
  end
end