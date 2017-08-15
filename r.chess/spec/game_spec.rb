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
