def fibs(iterations)
	x = 0
	base = 0
	add = 1
	until x == iterations
		result = base + add
		add = base
		base = result
		puts result
		x += 1
	end
end

#fibs(15)

def fibs_rec(n, base=0, add=1)
	if n == 1 
	 	return 1 
	else
		fibs_rec(n - 1, base + add, base)
	end
end

fibs_rec(4)


