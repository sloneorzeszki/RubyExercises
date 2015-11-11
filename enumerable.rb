module Enumerable
	def my_each
		return self unless block_given?
		for i in self
			yield i
		end
	end
	
	def my_each_with_index
		return self unless block_given?
		for i in self
			yield i, self.index(i)
		end
	end
	
	def my_select
		return self unless block_given?
		arr = []
		self.my_each{|x| arr << x if yield x}
		arr
	end
	
	def my_all?
		if block_given?
			self.my_each{|x| return false unless yield x}
		else
			self.my_each{|x| return false unless x}
		end
		true
	end
	
	def my_any?
		if block_given?
			self.my_each{|x| return true if yield x}
		else
			self.my_each{|x| return true if x}
		end
		false
	end
	
	def my_none?
		if block_given?
			self.my_each{|x| return false if yield x}
		else
			self.my_each{|x| return false if x}
		end
		true
	end	
	
end

puts %w[ant bear cat].my_all? { |word| word.length < 3 }
puts %w[ant bear cat].my_all? { |word| word.length >= 4 } 
puts [true, true, true].my_all?                              
