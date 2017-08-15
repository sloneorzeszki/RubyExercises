require '../lib/game'

include Helpers

RSpec.describe Game do
  describe "preparing all game elements" do
    it "creates board and squares in it" do
      expect(subject.board).to be_a Board
      expect(subject.board.squares).to be_a(Hash) 
    end

    it "creates two players" do
      expect(subject.players[1]).to be_a Player
      expect(subject.players[0]).to be_a Player
      expect(subject.players.size).to eql(2)
    end

    context "where the pieces" do
      let(:sorting_pieces) do
        sorted_pieces = {}
        subject.board.squares
          .collect { |key,val| val[:piece] }
          .group_by(&:class)
          .collect { |key, val| sorted_pieces[key.to_s.downcase] = val.size }
        sorted_pieces
      end
      
      it "have correct number of each piece type" do
        expect(sorting_pieces["rook"]).to eql 4
        expect(sorting_pieces["knight"]).to eql 4
        expect(sorting_pieces["bishop"]).to eql 4
        expect(sorting_pieces["queen"]).to eql 2
        expect(sorting_pieces["king"]).to eql 2
        expect(sorting_pieces["pawn"]).to eql 16
      end

      it "have pawns on the right squares" do
        [2, 7].each do |y|
          (1..8).each do |x|
            expect(subject.board.squares[to_key([x, y])][:piece]).to be_a Pawn
          end
        end
      end

      it "have other pieces on the right squares" do
        expect(subject.board.squares[:a1][:piece]).to be_a Rook
        expect(subject.board.squares[:a2][:piece]).to be_a Pawn
        expect(subject.board.squares[:b1][:piece]).to be_a Knight
        expect(subject.board.squares[:c1][:piece]).to be_a Bishop
        expect(subject.board.squares[:d1][:piece]).to be_a Queen
        expect(subject.board.squares[:e1][:piece]).to be_a King
      end
    end
  end

end

RSpec.describe Move do
  describe "each piece " do

  end    

  describe "making a move" do
    before do
      allow_any_instance_of(Move).to receive(:ask_for_move_details).with("from") { "c1" }
      allow_any_instance_of(Move).to receive(:ask_for_move_details).with("to") { "d1" }
      allow_any_instance_of(Move).to receive(:make_a_move)
      allow_any_instance_of(Move).to receive(:move_allowed?)
    end
    
    it "checks something" do
      # allow(@move).to receive(:ask_for_move_details).and_return("a1", "a6")
      # allow(Move).to receive(:gets).and_return("a1", "a6")
      # name = $stdin.gets
      @move = Move.new(Player.new("p1","white"), Board.new.squares)
      expect(@move.board).to be_a Board
      # expect(name).to eq("a6")
    #   expect(@move).to be_a Move
    #  @move.ask_for_move_details("from")
    #  expect(@move.from).to eq("a1")
    end
  end

  context "#within_possible_moves will return false" do
    it "if the square is already taken by a piece of the same color" do
    end

    it "when the move is out of reach of the piece (assuming blank board)" do
    end

    it "when the move is out of reach of the piece (other piece on the way)" do
    end

    it "if the move is out of the board" do
    end

    it "if the piece belongs to the other player" do
    end
  end
end