module Helpers
  def to_key(coords)
    [coords[0].ord - 96, coords[1].to_i]
  end
end