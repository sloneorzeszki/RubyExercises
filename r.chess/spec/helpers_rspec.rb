module HelpersRSpec
  def nullize(addr)
    boardsq=board.squares
    if addr.instance_of?(Array)
      addr.each do |address|
        boardsq[address.to_sym][:piece] = nil
      end
    else
      boardsq[addr.to_sym][:piece] = nil
    end
  end

  def move_piece(*moves)
    moves.each do |move|
      board.squares[move[1].to_sym][:piece] = board.squares[move[0].to_sym][:piece]
      board.squares[move[0].to_sym][:piece] = nil
    end
  end


end