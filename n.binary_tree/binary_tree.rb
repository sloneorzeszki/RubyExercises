
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

		arr.each_with_index do |new_node_val, index|
			next if index == 0 
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
			if @curr.child_right.nil?
				@curr = @curr.child_left
			else
				@curr = @curr.child_right
			end
		end
	end

	def breadth_first_search(target)
		queue = []
		queue << @start

		loop do 
			if queue[0].nil? then break else @current_node = queue[0] end

			if @current_node.val == target
				puts "rowna sie"
				break
			else
				puts @current_node.val
				puts "nie rowna sie"
				if  !@current_node.child_left.nil? 
					queue << @current_node.child_left
				end
				if  !@current_node.child_right.nil? 
					queue << @current_node.child_right
				end
				 #queue.each {|x| print x.val.to_s + " "}
				 #puts ""
				queue.shift
			end 
		end
	end

	def depth_first_search(target)
		stack = [@start]
		visited = [@start]

		until stack.empty?
			stack.each {|x| print x.val.to_s + " "}
			puts ""
			
			@current_node = stack.last

			return @current_node if @current_node.val == target

			if @current_node.child_left && !visited.include?(@current_node.child_left)
				stack << @current_node.child_left 
				visited << @current_node.child_left 
			elsif @current_node.child_right && !visited.include?(@current_node.child_right)
				stack << @current_node.child_right
				visited << @current_node.child_right
			else
				stack.pop
			end
				

		end
	end
end

drzewo = Tree.new([14, 1, 7, 4, 8, 9, 4,25,29,13,17])
#drzewo.display
#drzewo.breadth_first_search(13)
drzewo.depth_first_search(29)
