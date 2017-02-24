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

def fibs_rec(n)
	 n <= 2 ? 1 : fibs_rec(n-2) + fibs_rec(n-1)
end

puts fibs_rec(5)


