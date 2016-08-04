
class Node
	attr_accessor :val, :parent, :child_left, :child_right

	def initialize(val=0, parent=nil, child_left=nil, child_right=nil)
		@val = val
		@parent = parent
		@child_left = child_left
		@child_right = child_right
	end
end

class Tree
	def initialize(arr)
		build_tree(arr)
	end

	def build_tree(arr)
		@start = Node.new(arr[0])

		arr.each do |new_node_val|
			add_node(new_node_val)
		end
	end

 	def add_node(new_node_val)
 		@current_node = @start
 		
 		while 
	 		@parent = @current_node
	 		if new_node_val <= @current_node.val 
	 			@current_node = @current_node.child_left
	 			if @current_node.nil?
		 			nowy = Node.new(new_node_val,@parent,nil,nil)
		 			@parent.child_left = nowy
	 				break
	 			end
	 		else
	 			@current_node = @current_node.child_right
	 			if @current_node.nil?
		 			nowy = Node.new(new_node_val,@parent,nil,nil)
		 			@parent.child_right = nowy
	 				break
	 			end
	 		end
	 	end
	end

	def display
		@curr=@start
		until @curr.nil?
			puts @curr.val
			if @curr.child_right == nil 
				@curr = @curr.child_left
			else
				@curr = @curr.child_right
			end
		end
	end
end

drzewo = Tree.new([23, 1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
drzewo.display