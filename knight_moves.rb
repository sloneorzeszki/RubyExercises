class Node
	attr_accessor :val, :parent, :ch1, :ch2, :ch3, :ch4, :ch5, :ch6, :ch7, :ch8 

	def initialize(val, parent=nil, ch1=nil, ch2=nil, ch3=nil, ch4=nil, ch5=nil, ch6=nil, ch7=nil, ch8=nil)
		@val = val
		@parent = parent
	end
end


class Knight
	def initialize(starting_square=nil,target_square=nil)
		@start = Node.new(starting_square)
		@target_square=target_square
		@queue_nodes=[]
		@queue_nodes_temp=[]
		process
	end


	#generate all possible moves from the current position (in a form of child nodes for the current node)
	def possible_moves(root)
		@current_node = root
		x, y = root.val.first, root.val.last

		@queue_nodes_temp << root.ch1=Node.new([x+2,y+1],root) if within_board?(x+2,y+1)
		@queue_nodes_temp << root.ch2=Node.new([x+1,y+2],root) if within_board?(x+1,y+2)
		@queue_nodes_temp << root.ch3=Node.new([x-1,y+2],root) if within_board?(x-1,y+2)
		@queue_nodes_temp << root.ch4=Node.new([x-2,y+1],root) if within_board?(x-2,y+1)
		@queue_nodes_temp << root.ch5=Node.new([x-2,y-1],root) if within_board?(x-2,y-1)
		@queue_nodes_temp << root.ch6=Node.new([x-1,y-2],root) if within_board?(x-1,y-2)
		@queue_nodes_temp << root.ch7=Node.new([x+1,y-2],root) if within_board?(x+1,y-2)
		@queue_nodes_temp << root.ch8=Node.new([x+2,y-1],root) if within_board?(x+2,y-1) 
		return @queue_nodes_temp
	end

	#check if the calculated move is within the chessboard range
	def within_board?(x,y)
		squares_range = (0..7).to_a
		return true if squares_range.include?(x) && squares_range.include?(y)
	end

	#check if within the currently generated nodes/moves is one that is equal to target position
	def check_for_solution(current_node, target_square)

		loop do 
			@i+=1
			if @queue_nodes_temp[0].nil? then break else @current_node = @queue_nodes_temp[0] end

			if @current_node.val == target_square
				final_path = []
				until @current_node.nil?
					final_path << @current_node.val
					@current_node = @current_node.parent
				end
				p final_path.reverse
				#p @i.to_s + @current_node.val.to_s + "rowna sie"
				exit
			else
				#p @i.to_s + @current_node.val.to_s + "nie rowna sie"
				@queue_nodes_temp.shift
			end 
		end
	end

	#steps 
	def process
		@i=0
		@queue_nodes << @start

		while
			#p "runda kolejna"
			@queue_nodes.each { |node| possible_moves(node) }
			@queue_nodes += @queue_nodes_temp
			check_for_solution(@current_node, @target_square)
		end

	end
end

game = Knight.new([4,4],[0,7])