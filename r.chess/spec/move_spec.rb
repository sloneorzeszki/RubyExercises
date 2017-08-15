require '../lib/game'
require '../lib/move'

RSpec.describe Move do
  before do
    allow_any_instance_of(Move).to receive(:ask_for_move_details).with("from") { "b2" }
    allow_any_instance_of(Move).to receive(:ask_for_move_details).with("to") { "b3" }
  end

  let(:board) { Board.new }

  subject do 
    Move.new(Player.new("p1","white"), board.squares)
  end
  
  context "new instance will initialize" do
    it "all variables" do
      expect(subject.board).to be_a Hash
      expect(subject.player).to be_a Player
      expect(subject.from).to eq("b2")
      expect(subject.board[subject.from.to_sym]).to be_a Hash
      expect(subject.to).to eq("b3")
      expect(subject.board[subject.from.to_sym]).to be_a Hash
    end
  end

  context "#possible_move will return false" do
    it "if the square is already taken by a piece of the same color" do
    end

    it "when the move is out of reach of the piece (assuming blank board)" do
    end

    it "when the move is out of reach of the piece (other piece on the way)" do
    end

    it "if the move is out of the board (square does not exist)" do
    end

    it "if the piece belongs to the other player" do
    end
  end

  describe "Knight" do
    before do
      allow_any_instance_of(Move).to receive(:ask_for_move_details).with("from") { "b1" }
      allow_any_instance_of(Move).to receive(:ask_for_move_details).with("to") { "a3" }
    end

    it "changed the position of the piece on board" do
      expect(subject.board[subject.from.to_sym][:piece]).to be_a Knight
      expect(subject.board[subject.to.to_sym][:piece]).to be_nil
      subject.make_a_move
      expect(subject.board[subject.from.to_sym][:piece]).to be_nil
      expect(subject.board[subject.to.to_sym][:piece]).to be_a Knight
    end

  end
end
