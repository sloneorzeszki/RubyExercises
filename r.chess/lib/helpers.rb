module Helpers
  #return coordinates when address (key) provided
  def to_coords(key)
    [key[0].ord - 96, key[1].to_i]
  end

  #return key when coordinates provided
  def to_key(coords)
    [(coords[0]+96).chr, coords[1]].join.to_sym
  end

  #make an offset from the original coords
  def offset(coords, name = nil, multiplier = 1)
    x = coords[0]
    y = coords[1]

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
    when "up_double"
      [0, 2]
    when "knight_all"
      [[2,1], [1,2], [-1,2], [-2,1], [-2,1], [-1,-2], [1,-2], [2,-1]]
    else 
      [0, 0]
    end

    if name == "knight_all"
      offset.map! { |off| [x+off[0], y+off[1]] }
    else
      [x+offset[0], y+offset[1]]
    end
  end

  #check format of board address provided by user
  def address_valid?(add)
    ("a".."h").include?(add[0]) && add[1].to_i.between?(1,8) && add.size == 2
  end
end