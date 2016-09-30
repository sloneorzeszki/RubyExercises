#podziel na pol
#porownaj pierwszy element jednej polowy z pierwszym elementem drugiej polowy

def merge(arr)
puts arr.inspect.to_s + " size:" +arr.size.to_s

	if arr.size > 1 
		*[a] = merge(arr[0..(arr.size-1)/2])
		*[b] = merge(arr[(arr.size-1)/2+1..-1])
		
		puts a
		puts b
		sorted=[]
		
		until a.empty? && b.empty?
			x=a.shift || 0
			y=b.shift || 0
						
			if x > y
				sorted << y
			else
				sorted << x
			end
		end
		
	else
		return arr
	end
end

merge([15,4,78,50,8,23,42])