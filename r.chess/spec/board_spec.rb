require '../lib/board.rb'

RSpec.describe Board do
  it "will create @board hash variable" do
    expect(subject.board).to satisfy { |x| x.kind_of?(Hash) }
  end

  it "will have 64 elements" do
    expect(subject.board.size).to eql(64)
  end

  it "will have particular squares" do
    expect(subject.board).to include("a1", "b4", "c6", "h8")
  end
end