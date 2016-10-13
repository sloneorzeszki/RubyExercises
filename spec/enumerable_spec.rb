require './lib/enumerable'

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
  end

  context '#my_any?' do
  end

  context '#my_map?' do
  end

  context '#my_inject?' do
  end


end
