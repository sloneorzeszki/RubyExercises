module Helpers
  #return coordinates when address (key) provided
  def self.to_coords(key)
    [key[0].ord - 96, key[1].to_i]
  end

  def self.to_key(coords)
    [(coords[0]+96).chr, coords[1]].join
  end
end