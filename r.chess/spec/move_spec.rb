require '../lib/move'
require '../lib/player'
require '../lib/board'
require '../lib/helpers'
require './helpers_rspec'

RSpec.configure do |config|
  config.include HelpersRSpec
  config.include Helpers
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

  describe "#address_valid?"
    it "if it's within a board" do
      expect(subject.address_valid?("z7", "from")).to be false
    end

    it "for @from piece and player have same color" do
      expect(subject.address_valid?("h7", "from")).to be false
      expect(subject.address_valid?("a2", "from")).to be true
    end

    it "it's not empty" do
      expect(subject.address_valid?("a2", "to")).to be true
      expect(subject.address_valid?("a4", "from")).to be false
    end
  end

  describe "#possible_move?" do
    context "will return false" do
      it "if the square is already taken by a piece of the same color" do
        subject.board[:d3][:piece] = Rook.new("white")
        subject.from = "d2"
        subject.to = "d3"
        expect(subject.possible_move?(to_coords(subject.to))).to be false
      end

      it "if the move is out of the board (square does not exist)" do
        subject.from = "b9"
        subject.to = "i2"
        expect(subject.possible_move?(to_coords(subject.to))).to be false
        subject.to = "i2"
      end

      it "will not make move when piece is nil" do
        expect(subject.board[:a3][:piece]).to be_nil
        expect(subject.board[:c2][:piece]).to be_a Pawn
        subject.from = "a3" 
        subject.to = "c2"
        subject.apply_the_move if subject.within_possible_moves?
        expect(subject.board[:a3][:piece]).to be_nil
        expect(subject.board[:c2][:piece]).to be_a Pawn
      end
    end
  end

  describe "#within_possible_moves?" do
    context "identifies all allowed moves in the current board setup for" do
      before do
        nullize(%w(d2 e2))
        move_piece(["b2","b4"], ["h1","e6"], ["c2","c4"], ["f2","f4"], ["a1","a4"], ["b1","a3"], ["c1","f4"], ["d1","c2"], ["f1","f2"]) #white
        move_piece(["d7","f3"], ["f8","d3"], ["e8","d7"], ["h8","h6"], ["g8","f6"], ["d8","h4"], ["c8","b5"], ["b7","b5"], ["b8","e5"]) #black
      end

      it "Pawn" do
        board.graphical_display
        subject.from = "a2"
        expect(subject.possible_moves.sort).to eq([])
        subject.from = "a7"
        expect(subject.possible_moves.sort).to eq([[1,6],[1,5]].sort)
        subject.from = "g2"
        expect(subject.possible_moves.sort).to eq([[7,3],[7,4],[6,3]].sort)
        subject.from = "h2"
        expect(subject.possible_moves.sort).to eq([[8,3],[8,4]].sort)
        subject.from = "b4"
        expect(subject.possible_moves.sort).to eq([].sort)
        subject.from = "c4" #will not make up_double more than once
        expect(subject.possible_moves.sort).to eq([[2,5],[3,5]].sort)
      end
      
      it "King" do
      end
      
      it "Knight" do
      end
    end
  end

  describe "#make_a_move" do
    describe "will change the position (if correct) of" do
      context "Pawn" do
        it "will move by one square" do
          expect(subject.board[:a2][:piece]).to be_a Pawn
          expect(subject.board[:a3][:piece]).to be_nil
          subject.from = "a2" 
          subject.to = "a3"
          subject.apply_the_move if subject.within_possible_moves?
          expect(subject.board[:a2][:piece]).to be_nil
          expect(subject.board[:a3][:piece]).to be_a Pawn
        end

        it "will move by two squares" do
          expect(subject.board[:f2][:piece]).to be_a Pawn
          expect(subject.board[:f4][:piece]).to be_nil
          subject.from = "f2" 
          subject.to = "f4"
          subject.apply_the_move if subject.within_possible_moves?
          expect(subject.board[:f2][:piece]).to be_nil
          expect(subject.board[:f4][:piece]).to be_a Pawn
        end

        it "will move diagonally both ways only if opponent's piece present on square" do
          expect(subject.board[:c2][:piece]).to be_a Pawn
          expect(subject.board[:d3][:piece]).to be_nil
          subject.from = "c2" 
          subject.to = "d3"
          subject.apply_the_move if subject.within_possible_moves?
          expect(subject.board[:c2][:piece]).to be_a Pawn
          expect(subject.board[:d3][:piece]).to be_nil
          subject.board[:d3][:piece] = Rook.new("black")
          subject.apply_the_move if subject.within_possible_moves?
          expect(subject.board[:c2][:piece]).to be_nil
          expect(subject.board[:d3][:piece]).to be_a Pawn
          subject.from = "f2" 
          subject.to = "e3"
          subject.board[:e3][:piece] = Rook.new("black")
          subject.apply_the_move if subject.within_possible_moves?
          expect(subject.board[:f2][:piece]).to be_nil
          expect(subject.board[:e3][:piece]).to be_a Pawn
        end
      end

      it "Knight" do
        # expect(subject.board[subject.from.to_sym][:piece]).to be_nil
        # expect(subject.board[subject.to.to_sym][:piece]).to be_a Knight
      end

    end
  end
end