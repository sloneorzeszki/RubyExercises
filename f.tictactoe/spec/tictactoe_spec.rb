require '../lib/tictactoe.rb'

RSpec.configure do |rspec|
  rspec.deprecation_stream = 'log/rspec-deprecations.log'
  rspec.failure_color = :yellow
  rspec.tty = true
  rspec.color = true
end


describe Board do
  before do
   IO.any_instance.stub(:puts) #may be replace with any class in order to block puts from it
  end

  let(:game) {TicTacToe.new}

  context "#mark_move" do
    it "puts player's sign if field is blank" do
      game.board.mark_move([0,1],game.player1)
      expect(game.board.board).to eq([["_","X","_"],["_","_","_"],["_","_","_"]])
    end

    it "doesn't put the player's sign if field is already taken" do
      allow(game.player1).to receive(:select_value).and_return(2) #will be called only if there is a conflict (the second time the mark_move is run for [0,1]). returning the array with both coords ([0,1]) would loop in infinity, but returning 2 will result in coords [1,1] - conflict will appear only once which is enough for the purpose of this test
      game.board.mark_move([0,1],game.player1)
      game.board.mark_move([0,1],game.player1)
      expect(game.board.board).to eq([["_","X","_"],["_","X","_"],["_","_","_"]])
    end
  end

  context "#solved? checks whether the game should be ended" do
    it "recognizes the game solved vertically" do
      game.board.board = [["_","X","_"],["_","X","_"],["_","X","_"]]
      expect{game.board.solved?(game.player1)}.to raise_error(SystemExit)
    end

    it "recognizes the game solved horizontally" do
      game.board.board = [["X","X","X"],["_","_","_"],["_","X","_"]]
      expect{game.board.solved?(game.player1)}.to raise_error(SystemExit)
    end

    it "recognizes the game solved diagonally" do
      game.board.board = [["X","_","_"],["_","X","_"],["_","_","X"]]
      expect{game.board.solved?(game.player1)}.to raise_error(SystemExit)
    end
	
    it "recognizes a draw" do
      game.board.board = [["X","X","O"],["O","X","X"],["X","O","O"]]
      @found_dash = false
      game.board.board.each do |first_lvl|
        first_lvl.each do |second_lvl|
          if second_lvl == "_"
           @found_dash = true
          end
        end

       expect(@found_dash).to be false
       expect{game.board.solved?(game.player1)}.to raise_error(SystemExit)
      end
    end
  end
end



describe TicTacToe do
  before do
    IO.any_instance.stub(:puts) #możesz zastąpić IO jakąkolwiek klasą żeby ograniczyć blokowanie putsa tylko do niej
  end

  let(:game) {TicTacToe.new}

  context "a new instance of the class" do
    it "creates an object representing the game" do
      expect(game).to be_a TicTacToe
    end

    it "creates Board object" do
      expect(game.board).to be_a Board
      expect(game.board.board).to eq([["_","_","_"],["_","_","_"],["_","_","_"]])
    end

    it "creates two players with X/O signs" do
      allow($stdin).to receive(:gets).and_return(["player1_name","player2_name"])
      names = $stdin.gets
      game.player1.name = names[0]
      game.player2.name = names[1]
      expect(game.player1).to be_a Player
      expect(game.player2).to be_a Player
      expect(game.player1.sign).to eql ("X")
      expect(game.player2.sign).to eql ("O")
      expect(game.player1.name).to eql ("player1_name")
      expect(game.player2.name).to eql ("player2_name")
    end
  end
end