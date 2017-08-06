require '../lib/game'

RSpec.describe Game do
  context "prepares all game elements" do
    it "including board and squares in it" do
      expect(subject.board).to be_a Board
      expect(subject.board.squares).to be_a(Hash) 
    end

    it "including players" do
      
    end

  end
  
end