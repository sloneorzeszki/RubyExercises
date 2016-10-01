class Node
	attr_accessor :val, :ch1, :ch2, :ch3, :ch4, :ch5, :ch6, :ch7, :ch8 

	def initialize(val, ch1=nil, ch2=nil, ch3=nil, ch4=nil, ch5=nil, ch6=nil, ch7=nil, ch8=nil)
		@val = val
	end
end


def possible_moves_tree(start,finish=[0,0])
	root = Node.new(start)
	x,y=root.val.first,root.val.last
	root.ch1=Node.new([x+2,y+1]) if within_board?(x+2,y+1)
	root.ch2=Node.new([x+1,y+2]) if within_board?(x+1,y+2)
	root.ch3=Node.new([x-1,y+2]) if within_board?(x-1,y+2)
	root.ch4=Node.new([x-2,y+1]) if within_board?(x-2,y+1)
	root.ch5=Node.new([x-2,y-1]) if within_board?(x-2,y-1)
	root.ch6=Node.new([x-1,y-2]) if within_board?(x-1,y-2)
	root.ch7=Node.new([x+1,y-2]) if within_board?(x+1,y-2)
	root.ch8=Node.new([x+2,y-1]) if within_board?(x+2,y-1)


	puts root.ch1.inspect
	puts root.ch2.inspect
	puts root.ch3.inspect
	puts root.ch4.inspect
	puts root.ch5.inspect
	puts root.ch6.inspect
	puts root.ch7.inspect
	puts root.ch8.inspect
end

def within_board?(x,y)
	squares_range = (0..7).to_a
	return true if squares_range.include?(x) && squares_range.include?(y)
end

possible_moves_tree([1,3])