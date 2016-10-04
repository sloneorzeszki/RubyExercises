require 'spec_helper'

context Knight do
	is "even real?" 
		knight = Knight.new(nil)
		knight.val.should be_nil
end