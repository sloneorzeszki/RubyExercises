require 'caesar_cipher'


describe "caesar_cipher" do
	it 'makes a round of z to a' do
		expect(caesar_cipher('z',1)).to eql('a')
	end
	
	it 'keeps the uppercase' do
	end
	
	it 'keeps the lowercase' do
	end
	
	it 'lets you enter number bigger than amount of letters in alphabet' do
	end
	
	it 'lets you enter special signs like hash, dollar and space' do
	end
	
	it 'returns "What a string!"' do 
	end
end
