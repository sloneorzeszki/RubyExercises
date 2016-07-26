

def fibs_rec(n, start = 0, add = 1)
puts n == 1 ? add : fibs_rec(n - 1, add, start + add)
end

fibs_rec(5)