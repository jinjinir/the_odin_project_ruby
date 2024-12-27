#!/usr/bin/env ruby

def stock_picker(prices)
  return [] if prices.length < 2 # edge case: need at least 2 days to buy and sell

  best_buy_day = 0
  best_sell_day = 1
  max_profit = 0

  # loop through each day as a potential buying day
  prices.each_with_index do |buy_price, buy_day|
    # for each buy day, look at all the future days as potential selling days
    ((buy_day + 1)...prices.length).each do |sell_day|
      sell_price = prices[sell_day]
      profit = sell_price - buy_price

      # update best days if we find a better profit
      next unless profit > max_profit

      max_profit = profit
      best_buy_day = buy_day
      best_sell_day = sell_day
    end
  end
  [best_buy_day, best_sell_day]
end

prices = [17, 3, 6, 9, 15, 8, 6, 1, 10, 20]

buy_sell_days = stock_picker(prices)

puts "Best buy day is #{buy_sell_days[0]}"
puts "Best sell day is #{buy_sell_days[1]}"
