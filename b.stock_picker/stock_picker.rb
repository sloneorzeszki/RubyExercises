def stock_picker(prices)
  max_profit, results = 0, {}
  prices.each.with_index (1) do |buy_price, buy_day|

    days_to_sell = prices[buy_day..-1] 
    (print_output(results) && exit) if finish?(days_to_sell)
    
    days_to_sell.each.with_index(1) do |sell_price, sell_day|
      profit = sell_price - buy_price
      if profit > max_profit
        max_profit = profit
        results = {buy_price: buy_price, buy_day: buy_day, sell_price: sell_price, sell_day: buy_day + sell_day }
      end
    end
  end
end

def print_output(results)
  puts "buy a #{results[:buy_price]} on day #{results[:buy_day]}, sell at #{results[:sell_price]} on day #{results[:sell_day]}" 
end

def finish?(days_to_sell)
  days_to_sell.size == 1
end