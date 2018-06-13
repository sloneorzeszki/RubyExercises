module Helpers
  def to_coords(addr)
    [addr[0].ord - 96, addr[1].to_i]
  end

  def to_addr(coords)
    [(coords[0]+96).chr, coords[1]].join.to_sym
  end

  def within_board?(add)
    ("a".."h").include?(add[0]) && add[1].to_i.between?(1,8)
  end

  def start_position_allowed?(start_position)
    if !within_board?(start_position)
      puts "Selected starting position if out of board. Please try again."
      exit
    else
      true
    end
  end
end
