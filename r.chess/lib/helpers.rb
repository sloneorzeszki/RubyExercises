module Helpers
  #return coordinates when address (key) provided
  def to_coords(key)
    [key[0].ord - 96, key[1].to_i]
  end

  #return key when coordinates provided
  def to_key(coords)
    [(coords[0]+96).chr, coords[1]].join.to_sym
  end

  def offset(coords, name = nil, multiplier = 1)
    offset = case name
    when "up_right"
      [1*multiplier, 1*multiplier]
    when "up_left"
      [-1*multiplier, 1*multiplier]
    when "down_left"
      [-1*multiplier, -1*multiplier]
    when "down_right"
      [1*multiplier, -1*multiplier]
    when "down"
      [0, -1*multiplier]
    when "up"
      [0, 1*multiplier] 
    when "right"
      [1*multiplier, 0] 
    when "left"
      [-1*multiplier, 0] 
    else 
      [0, 0]
    end
    
    [coords[0]+offset[0], coords[1]+offset[1]]
  end


  def within_board?(square)
    squares_range = (1..8).to_a
    return true if squares_range.include?(square[:coords].first) && squares_range.include?(square[:coords].last)
  end
end