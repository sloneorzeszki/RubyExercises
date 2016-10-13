class Node
	attr_accessor :value, :next_node
	def initialize(value=nil, next_node=nil)
		@value = value
		@next_node = next_node
	end
end


class LinkedList
	def initialize(value)
		@head = Node.new(value)
		@tail = @head
		@tail.next_node = nil
	end

	def append(value)
		appended_node = Node.new(value)
		@tail.next_node = appended_node
		@tail = appended_node
	end

	def prepend(value)
		prepended_node = Node.new(value)
		prepended_node.next_node = @head
		@head = prepended_node
	end

	def test
		puts @tail.next_node.inspect
	end

	def tail
		return @tail
	end

	def head
		return @head
	end


	def to_s
		current = @head.next_node
		print @head.value
		until current.nil? do
			print  " >> " + current.value.to_s 
			current = current.next_node
		end
		puts ""
	end

	def size
		current = @head
		counter = 0
		until current.nil? do
			counter += 1
			current = current.next_node
		end
		return counter
	end

	def at(index)
		current = @head
		counter = 0
		until counter == index do
			if !current.next_node.nil?
				current = current.next_node
				counter += 1
			else
				puts "No such index in this list!"
				exit
			end
		end
		return current
	end

	def contains?(value)
		current = @head
		until current.nil? do
			if current.value == value
				return true
			else
				current = current.next_node
			end
		end
		return false
	end

	def pop
		size = self.size
		last_but_one = self.at(size-2)
		last_but_one.next_node = nil
	end

	def find(data)
		current = @head
		counter = 0
		until current.nil? do
			if current.value == data
				return counter
			else
				counter += 1
				current = current.next_node
			end
		end
		return nil
	end

end


newList = LinkedList.new(6)
newList.append(5)
newList.append(8)
newList.append(10)
newList.prepend(9)


#newList.contains?
newList.to_s
#puts "Size: " + newList.size.to_s
#puts newList.head
#puts newList.tail
#puts newList.at(5)
puts newList.pop
newList.to_s
puts newList.contains?(5)
puts newList.find(546)

