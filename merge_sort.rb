def merge_sort(arr)
	#puts arr.inspect.to_s + " size:" +arr.size.to_s
	return arr if arr.size == 1 
	a, b = merge_sort(arr[0..(arr.size-1)/2]), merge_sort(arr[(arr.size-1)/2+1..-1])
	merge(a,b)
end

def merge(a,b)
	sorted = []
	sorted.push(a[0] > b[0] ? b.shift : a.shift)
	return sorted
end




puts merge_sort([15,4,78,50,8,23,42])