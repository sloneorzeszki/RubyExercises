require '../lib/board.rb'

RSpec.describe Board do
  it "has a method to create board" do
    expect(subject).to respond_to(:create_board)
  end

  it "will create @board hash variable" do
    expect(subject.board).to satisfy { |x| x.kind_of?(Hash) }
  end

  it "will have 64 elements" do
    expect(subject.board.size).to eql(64)
  end

  context "the squares" do
    it "have some particular addresses" do
      expect(subject.board).to include("a1", "b4", "c6", "h8")
    end

    it "have coordinates (hash val) in an array form" do
      expect(subject.board["a1"]).to be_an(Array)
    end

    it "have coordinates appropriate to their address" do
      expect(subject.board["a3"]).to eql([1,3])
      expect(subject.board["d5"]).to eql([4,5])
      expect(subject.board["f2"]).to eql([6,2])
    end

    let(:compare) do
      h=Hash.new { |has, key| has[key] = 0 }
      subject.board.keys.collect {|key| key[0]}.each{|letter| h[letter] += 1}
      h.all? { |key, val| val == 8 }
    end

    it "each column a-h has 8 rows" do
      expect(compare).to be true
    end
  end
end