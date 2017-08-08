module Helpers
  #return coordinates when address (key) provided
  def to_coords(key)
    [key[0].ord - 96, key[1].to_i]
  end

  def to_key(coords)
    [(coords[0]+96).chr, coords[1]].join.to_sym
  end
end