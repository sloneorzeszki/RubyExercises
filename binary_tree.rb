
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
		 			@parent.child_left = Node.new(new_node_val,@parent,nil,nil)
		 			break
	 			end
	 		else
	 			@current_node = @current_node.child_right
	 			if @current_node.nil?
		 			@parent.child_right = Node.new(new_node_val,@parent,nil,nil)
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

	def breadth_first_search(target)
		queue = []
		@current_node = @start
		while 
			if @current_node == target
				puts @current_node.val
				break
			else
				if  !@current_node.child_left.nil? 
					queue << @current_node.child_left
				end
				if  !@current_node.child_right.nil? 
					queue << @current_node.child_right
				end
				@current_node = queue[0]
			end 
					end
		
	end

	def depth_first_seach

	end
end

drzewo = Tree.new([23, 1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
drzewo.display
drzewo.breadth_first_search(8)