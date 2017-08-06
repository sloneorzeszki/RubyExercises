class Node
  attr_accessor :val, :parent

  def initialize(val, parent=nil)
    @val = val
    @parent = parent
  end
end

class Knight
  def initialize(starting_square = nil, target_square = nil)
    @start = Node.new(starting_square)
    @target_square = target_square
    @queue_nodes = []
    @queue_nodes_temp = []
    process
  end

  # generate all possible moves from the current position - one way relation
  # (child knows parent, parent doesn't know child - as the path goes bottom to top)
  def possible_moves(root)
    @current_node = root
    x, y = root.val.first, root.val.last
    moves = [[x+2,y+1], [x+1,y+2], [x-1,y+2], [x-2,y+1], [x-2,y-1], [x-1,y-2], [x+1,y-2], [x+2,y-1]]
    moves.each { |move| @queue_nodes_temp << Node.new(move,root) if within_board?(move)}
  end

  # check if the calculated move is within the chessboard range
  def within_board?(square)
    squares_range = (0..7).to_a
    return true if squares_range.include?(square.first) && squares_range.include?(square.last)
  end

  # check if within the currently generated nodes/moves is one that is equal to target position
  def check_for_solution(current_node, target_square)
    loop do
      # loop until the temporary queue is empty 
      # (at this point these nodes are already added to @queue_nodes)
      if @queue_nodes_temp.empty? then break else @current_node = @queue_nodes_temp[0] end

      # check if any of the recently created nodes has the target value, 
      # if not - exit to 'process' and create children for them, if yes - print the path
      if @current_node.val == target_square
        final_path = []
        until @current_node.nil?
          final_path << @current_node.val
          @current_node = @current_node.parent
        end
        p final_path.reverse
        exit
      else
        @queue_nodes_temp.shift
      end
    end
  end

  #main loop - until solution is found
  def process
    @queue_nodes = [@start]
    while
      @queue_nodes.each { |node| possible_moves(node) }
      @queue_nodes += @queue_nodes_temp
      check_for_solution(@current_node, @target_square)
    end
  end
end

Knight.new([0, 4], [6, 4])
