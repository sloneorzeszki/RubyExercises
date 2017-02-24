def bubble_sort(arr)
  changed = true
  while changed
    changed = false
    for i in 0..arr.size-2
      if arr[i]>arr[i+1]
        arr[i],arr[i+1] = arr[i+1],arr[i] 
        changed = true
      end
    end
  end
  
  puts arr.inspect
end
 
bubble_sort([4,3,78,2,0,2])

def bubble_sort_by(arr)
  changed = true
  while changed
    changed = false
    for i in 0..arr.size-2
      if yield(arr[i],arr[i+1]) > 0
        arr[i],arr[i+1] = arr[i+1],arr[i] 
        changed = true
      end
    end
  end
  
  puts arr.inspect
end


bubble_sort_by(["hi","hello","hey"]) do |left,right|
  left.length - right.length
end
