require '../stock_picker.rb'

RSpec.describe "stock picker" do
  before(:context) do
    @arr = [1,18,4,8,17,3,6,9,19]
  end

  context "stock_picker method" do
    it "will return a string with correct results" do
      expect { stock_picker(@arr) }.to output(/buy at 1 on day 1, sell at 19 on day 9/).to_stdout
    end
  end
  
  context "finish? method" do
    it "will return true with only one element left" do
      arr = [1]
      expect(finish?(arr)).to be true
    end

    it "will return false if more than one element left" do
      arr=[1,2]
      expect(finish?(arr)).to be false
    end
  end

end