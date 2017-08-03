require '../lib/caesar_cipher'

describe "Caesar Cipher" do
	it 'wraps alphabet' do
		expect(caesar_cipher('z',1)).to eq('a')
	end

	it 'keeps the uppercase and lowercase' do
		expect(caesar_cipher('ZzAa',1)).to eq('AaBb')		
	end

	it 'keeps special characters (hash, dollar etc)' do
		expect(caesar_cipher('$%^&',1)).to eq('$%^&')		
	end

	it 'accepts shift bigger than number of letters in alphabet' do
		expect(caesar_cipher('ZzAa',27)).to eq('AaBb')		
	end

	it 'accepts shift equal to zero' do
		expect(caesar_cipher('Zz  Aa',0)).to eq('Zz  Aa')		
	end 
end