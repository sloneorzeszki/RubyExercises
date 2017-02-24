def stock_picker(prices)
  max_profit = 0
  days = []
  prices.each_with_index do |x, y|
    for i in y + 1...prices.count
      if prices[i] - x > max_profit
        max_profit = prices[i] - x
        days = [y, i].to_s
      end
    end
  end
  puts days
end

stock_picker([17,3,6,9,15,8,6,1,10])
