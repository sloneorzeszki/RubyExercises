require '../lib/game'
require 'pry'

RSpec.describe Game do
  describe "preparing all game elements" do
    it "creates board and squares in it" do
      expect(subject.board).to be_a Board
      expect(subject.board.squares).to be_a(Hash) 
    end

    it "creates create two players" do
      expect(subject.player_white).to be_a Player
      expect(subject.player_black).to be_a Player
      expect(subject.players.size).to eql(2)
    end

    context "the pieces" do
      let(:sorting_pieces) do
        sorted_pieces = {}
        subject.board.squares
          .collect { |key,val| val[:piece] }
          .group_by(&:class)
          .collect { |key, val| sorted_pieces[key.to_s.downcase] = val.size }
        sorted_pieces
      end
      
      it "has correct number of each piece type" do
        expect(sorting_pieces["rook"]).to eql 4
        expect(sorting_pieces["knight"]).to eql 4
        expect(sorting_pieces["bishop"]).to eql 4
        expect(sorting_pieces["queen"]).to eql 2
        expect(sorting_pieces["king"]).to eql 2
        expect(sorting_pieces["pawn"]).to eql 16
      end

      it "has pawns on the right squares" do
        [2, 7].each do |y|
          (1..8).each do |x|
            expect(@board.squares[Helpers.to_key([x, y])][:piece]).to be_a Pawn
          end
        end
      end

      it "has other pieces on the right squares" do

      end
    end
  end
end