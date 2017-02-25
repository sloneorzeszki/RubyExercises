module Enumerable
  def my_each
    return self.to_enum unless block_given?
      for i in self
        yield i
    end
  end
  
  def my_each_with_index
    return self.to_enum unless block_given?
    for i in self
      yield i, self.index(i)
    end
  end
  
  def my_select
    return self.to_enum unless block_given?
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
  
  def my_map
    return self.to_enum unless block_given?
    arr = []
    self.my_each{|x| arr << yield(x)}
    arr
  end
  
  def my_map_proc(proc)
    arr = []
    self.my_each{|x| arr << proc.call(x) }
    arr
  end
  
  def my_map_proc_or_block(proc = nil)
    arr = []
    self.my_each{|x| arr << proc.call(x) } if proc 
    
    if proc && block_given?
      arr2 = []
      arr.my_each_with_index {|x,y| arr2[y] = yield(x)} 
    end
    arr2 || arr
  end  
  
  
  def my_inject(*args)
    return self.to_enum unless block_given?
    arr = self.to_a    
    
    if args[0]
      acc = args[0]
      start = 0
    else
      acc = arr[0] 
      start = 1
    end 
    
    for i in arr[start..-1]
      acc = yield(acc,i) 
    end
    acc
  end  
  
  
end

#test = Proc.new { |x| x*2 }
#[1,2,3].my_each_with_index { |x,y| puts [x,y].inspect }
#puts [1,2,3,4,5].my_map_proc_or_block(test) { |x| x*2 }
