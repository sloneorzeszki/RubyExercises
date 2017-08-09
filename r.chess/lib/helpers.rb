module Helpers
  #return coordinates when address (key) provided
  def to_coords(key)
    [key[0].ord - 96, key[1].to_i]
  end

  #return key when coordinates provided
  def to_key(coords)
    [(coords[0]+96).chr, coords[1]].join.to_sym
  end

  ######## CREATE GAME HELPERS #########
  def create_pawns
    [["white", 2], ["black", 7]].each do |color, y| 
      (1..8).each { |x| @board[to_key([x, y])][:piece] = Pawn.new(color) } 
    end
  end

  def create_non_pawns
    [["white", 1], ["black", 8]].each do |color, y| 
      [1, 8].each { |x| @board[to_key([x, y])][:piece] = Rook.new(color) } 
      [2, 7].each { |x| @board[to_key([x, y])][:piece] = Knight.new(color) } 
      [3, 6].each { |x| @board[to_key([x, y])][:piece] = Bishop.new(color) } 
      [4].each    { |x| @board[to_key([x, y])][:piece] = Queen.new(color) } 
      [5].each    { |x| @board[to_key([x, y])][:piece] = King.new(color) } 
    end
  end

  ######## MOVE VALIDATION #########
  def address_valid?(address)
    ("a".."h").include?(address[0]) && address[1].to_i.between?(1,8)
  end

  def move_allowed?(from, to)
    piece_same_color_as_player(from)
    in_general_range_of_piece(from, to) #as if all squares were blank
    in_actual_range_of_piece(from, to) #considering actual positions of other pieces
    target_piece_different_color?(to) unless @board[to.to_sym].nil?
    no_check_for_the_current_player?(from, to)
  end
end