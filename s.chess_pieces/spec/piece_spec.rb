require '../piece.rb'

RSpec.describe King do
  describe "#possible_moves" do
    subject { King.new('a1') }
    it "will return correct values of allowed moves" do
      expect(subject.possible_moves.sort).to match_array([[1,2], [2,2], [2,1]]) 
      subject.from = [6,5]
      coords = [[6,6], [6,4], [7,6], [7,4], [7,5], [5,5], [5,6], [5,4]]
      expect(subject.possible_moves.sort).to match_array(coords) 
    end
  end

  describe "#display_possible_moves" do
    it "will output (puts) changed coords to addresses (e.g. b3, c6)" do
      expect(STDOUT).to receive(:puts).with(["a2", "b1", "b2"].sort.to_s)
      King.new('a1')
    end
  end
end

RSpec.describe Knight do
  describe "#possible_moves" do
    subject { Knight.new('a1') }
    it "will return correct values of allowed moves" do
      expect(subject.possible_moves.sort).to match_array([[2,3], [3,2]]) 
      subject.from = [6,6]
      coords = [[7,8],[5,8],[7,4],[8,7],[8,5],[4,7],[4,5],[5,4]]
      expect(subject.possible_moves.sort).to match_array(coords) 
    end
  end

  describe "#display_possible_moves" do
    it "will output (puts) changed coords to addresses (e.g. b3, c6)" do
      expect(STDOUT).to receive(:puts).with(["b3", "c2"].sort.to_s)
      Knight.new('a1')
    end
  end
end

RSpec.describe Rook do
  describe "#possible_moves" do
    subject { Rook.new('a1') }
    it "will return correct values of allowed moves" do
      coords = [[1,2],[1,3],[1,4],[1,5],[1,6],[1,7],[1,8],
                [2,1],[3,1],[4,1],[5,1],[6,1],[7,1],[8,1]]
      expect(subject.possible_moves.sort).to match_array(coords) 
      subject.from = [6,6]
      coords = [[6,7],[6,8],[6,5],[6,4],[6,3],[6,2],[6,1],
                [1,6],[2,6],[3,6],[4,6],[5,6],[7,6],[8,6]]
      expect(subject.possible_moves.sort).to match_array(coords) 
    end
  end

  describe "#display_possible_moves" do
    it "will output (puts) changed coords to addresses (e.g. b3, c6)" do
      addresses = %w(a2 a3 a4 a5 a6 a7 a8 b1 c1 d1 e1 f1 g1 h1)
      expect(STDOUT).to receive(:puts).with(addresses.sort.to_s)
      Rook.new('a1')
    end
  end
end

RSpec.describe Bishop do
  describe "#possible_moves" do
    subject { Bishop.new('a1') }
    it "will return correct values of allowed moves" do
      expect(subject.possible_moves.sort)
        .to match_array([[2,2],[3,3],[4,4],[5,5],[6,6],[7,7],[8,8]])
      subject.from = [6,6]
      expect(subject.possible_moves.sort)
        .to match_array([[7,7],[8,8],[5,5],[4,4],[3,3],[2,2],[1,1],[5,7],[4,8],[7,5],[8,4]]) 
    end
  end

  describe "#display_possible_moves" do
    it "will output (puts) changed coords to addresses (e.g. b3, c6)" do
      addresses = %w(b2 c3 d4 e5 f6 g7 h8)
      expect(STDOUT).to receive(:puts).with(addresses.sort.to_s)
      Bishop.new('a1')
    end
  end
end

RSpec.describe Queen do
  describe "#possible_moves" do
    subject { Queen.new('a1') }
    it "will return correct values of allowed moves" do
      expect(subject.possible_moves.sort)
        .to match_array([[2,2],[3,3],[4,4],[5,5],[6,6],[7,7],[8,8],
                         [1,2],[1,3],[1,4],[1,5],[1,6],[1,7],[1,8],
                         [2,1],[3,1],[4,1],[5,1],[6,1],[7,1],[8,1]])
      subject.from = [6,6]
      expect(subject.possible_moves.sort)
        .to match_array([[7,7],[8,8],[5,5],[4,4],[3,3],[2,2],[1,1],[5,7],[4,8],
                 [7,5],[8,4],[6,7],[6,8],[6,5],[6,4],[6,3],[6,2],[6,1],
                 [1,6],[2,6],[3,6],[4,6],[5,6],[7,6],[8,6]]) 
    end
  end

  describe "#display_possible_moves" do
    it "will output (puts) changed coords to addresses (e.g. b3, c6)" do
      addresses = %w(b2 c3 d4 e5 f6 g7 h8 a2 a3 a4 a5 a6 a7 a8 b1 c1 d1 e1 f1 g1 h1)
      expect(STDOUT).to receive(:puts).with(addresses.sort.to_s)
      Queen.new('a1')
    end
  end
end

