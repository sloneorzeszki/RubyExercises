require '../lib/board.rb'

RSpec.describe Board do
  it "has a method to create board" do
    expect(subject).to respond_to(:create_squares)
  end

  it "will create @board hash variable" do
    expect(subject.squares).to satisfy { |x| x.kind_of?(Hash) }
  end

  it "will have 64 elements" do
    expect(subject.squares.size).to eql(64)
  end

  context "the squares" do
    it "have some particular addresses" do
      expect(subject.squares).to include(:a1, :b4, :c6, :h8)
    end

    it "have coordinates (hash val) in an array form" do
      expect(subject.squares[:a1]).to be_a(Hash)
    end

    it "have coordinates appropriate to their address" do
      expect(subject.squares[:a3][:coords]).to eql([1,3])
      expect(subject.squares[:d5][:coords]).to eql([4,5])
      expect(subject.squares[:f2][:coords]).to eql([6,2])
    end

    let(:compare) do
      h=Hash.new { |has, key| has[key] = 0 }
      subject.squares.keys.collect {|key| key[0]}.each{|letter| h[letter] += 1}
      h.all? { |key, val| val == 8 }
    end

    it "each column a-h has 8 rows" do
      expect(compare).to be true
    end
  end
end