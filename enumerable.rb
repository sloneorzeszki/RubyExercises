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
	
	def my_count(*arg)
		count = 0
		if arg[0] == nil
			if block_given?
				for i in self
					count += 1 if yield i
				end
			else
				for i in self
					count += 1
				end			
			end
		else
			for i in self
				count += 1 if i == arg[0]
			end	
		end	
		count	
	end
	
end
ary = [1, 2, 4, 2]
puts ary.my_count               
puts ary.my_count(2)            
puts ary.my_count{ |x| x%2==0 }
