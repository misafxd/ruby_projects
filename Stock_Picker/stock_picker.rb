# Implement a method #stock_picker that takes in an array of
# stock prices, one for each hypothetical day.
# It should return a pair of days representing 
# the best day to buy and the best day to sell. Days start at 0.

def stock_picker(stock_prices)
    result = 0
    days = []
    stock_prices.each_with_index do |price, idx|
        if (stock_prices[idx..-1].max - price) > result
            result = stock_prices[idx..-1].max - price
            days = [idx, stock_prices.index(stock_prices[idx..-1].max)]
        end
    end
    days
end

puts stock_picker([17,3,6,9,15,8,6,1,10]) 
#[1,4] for a profit of $15 - $3 = $12
puts stock_picker([24,2,5,6,9,7,4,10,2])
#[1,7] for a profit of $10 - $2 = $8