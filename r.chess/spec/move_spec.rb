require '../lib/move'

RSpec.describe Move do
  describe "new move initialize" do
    it "board variable" do
      expect(subject.instance_variables).to include(@board) 
    end
  end
end