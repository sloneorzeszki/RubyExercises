require '../lib/enumerable.rb'

describe Enumerable do 
  let(:arr) {[5,6,3]}

  context '#my_each' do
    it "doesn't change array contents" do
      expect(arr.my_each {|x| x+6}).to eq(arr) 
    end

    it "returns an array" do
      expect(arr.my_each {|x| x}).to be_instance_of(Array) 
    end

    it "returns a Enumerator type" do
      expect(arr.my_each).to be_instance_of(Enumerator)
    end

    it "iterates through all values" do
      x=0
      arr.my_each { |n| x+=n }
      expect(x).to eq(14)
    end
  end 

  context "#my_select" do
    it "returns array with values matching the conditions" do
      expect(arr.my_select{|x| x > 4}).to eq([5,6])
    end

    it "returns error when called not on array" do
      expect {nil.my_select }.to raise_error NoMethodError 
      expect { 10.my_select }.to raise_error NoMethodError 
      expect { "test".my_select }.to raise_error NoMethodError
    end
  end

  context '#my_all?' do
	it "returns false when not all elements meet condition" do
		expect(arr.my_all? { |x| x > 4 }).to be false
	end
  end

  context '#my_any?' do
	it "returns true when any of the elements meets the condition" do
		expect(arr.my_any? { |x| x > 4 }).to be true
	end
  end

  context '#my_map?' do
	it "returns a modified array" do
		expect(arr.my_map { |x| x * 7 }).to eq([35,42,21])
	end
  end

  context '#my_inject?' do
	it "returns a sum of multiple numbers with a customed value of accumulator" do
		expect(arr.my_inject(5) {|acc, x| acc + x }).to eq(19)
	end
  end
end
