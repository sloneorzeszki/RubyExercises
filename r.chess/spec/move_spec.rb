require '../lib/move'
require '../lib/player'
require '../lib/board'
require './helpers_rspec.rb'

RSpec.configure do |config|
  config.include HelpersRSpec
end

RSpec.describe Move do
  before do
    allow_any_instance_of(Move).to receive(:ask_for_address).with("from") { "b2" }
    allow_any_instance_of(Move).to receive(:ask_for_address).with("to") { "b3" }
  end

  let(:board) { Board.new }
  subject { Move.new(Player.new("p1","white"), board.squares) }

  describe "#initialize" do
    context "will create" do
      it "all variables" do
        expect(subject.board).to be_a Hash
        expect(subject.player).to be_a Player
        expect(subject.from).to eq("b2")
        expect(subject.board[subject.from.to_sym]).to be_a Hash
        expect(subject.to).to eq("b3")
        expect(subject.board[subject.from.to_sym]).to be_a Hash
      end
    end
  end

  describe "#possible_move?" do
    context "will return false" do
      before do
        nullize(%w(a2 b2 c2 d2 e2))
        move_piece(["f2","f4"], ["a1","a4"], ["b1","a3"], ["c1","f4"], ["d1","c2"]) #white
        move_piece(["g8","f6"], ["d8","h4"], ["c8","b5"], ["b7","b5"], ["b8","e5"]) #black
      end

      it "if the square is already taken by a piece of the same color" do
        board.graphical_display
      end

      it "if the move is out of the board (square does not exist)" do
        expect(subject.possible_move?([1,3])).to be false
      end

      it "if the piece belongs to the other player" do
      end

      it "if there is no piece to move on @from square" do
      end
    end
  end

  describe "#within_possible_moves?" do
    context "identifies all allowed moves in the current setup for" do
      before do 
        #make moves to change the initial state on the board so that testing 
        #possible moves for each type of piece is possible
      end

      it "Pawn" do
        #expect(subject.within_possible_moves?(from for pawn). to eq([[3,1],[3,2]]))
      end
      
      it "King" do
      end
      
      it "Knight" do
      end
    end
  end

  describe "#make_a_move" do
    describe "will change the position of" do
      before do
        allow_any_instance_of(Move).to receive(:ask_for_address).with("from") { "b1" }
        allow_any_instance_of(Move).to receive(:ask_for_address).with("to") { "a3" }
        allow(Move).to receive(:apply_the_move).and_return(nil)
      end

      it "Knight" do
        # subject.make_a_move
        expect(subject.board[subject.from.to_sym][:piece]).to be_nil
        expect(subject.board[subject.to.to_sym][:piece]).to be_a Knight
      end

    end
  end
end