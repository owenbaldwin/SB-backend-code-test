class Checkout
  attr_reader :prices
  private :prices

  def initialize(prices)
    @prices = prices
  end

  def scan(item)
    basket << item.to_sym
  end

  def total
    total = 0

    basket.inject(Hash.new(0)) { |items, item| items[item] += 1; items }.each do |item, count|
      if item == :apple || item == :pear
        if (count % 2 == 0)
          total += prices.fetch(item) * (count / 2)
        else
          total += prices.fetch(item) * count
        end
      elsif item == :banana || item == :pineapple
        if item == :pineapple
          total += (prices.fetch(item) / 2)
          total += (prices.fetch(item)) * (count - 1)
        else
          total += (prices.fetch(item) / 2) * count
        end
      elsif item == :mango
        total += ((prices.fetch(item)) * ((count - (count % 3)) * 2 / 3) + (prices.fetch(item)) * (count % 3))
      else
        total += prices.fetch(item) * count
      end
    end

    total
  end

  private

  def basket
    @basket ||= Array.new
  end
end




# Unrefactored mango discount
# if (count % 3 == 0)
#   total += (prices.fetch(item)) * (count * 2 / 3)
# elsif (count > 3 && count % 3 == 1)
#   total += ((prices.fetch(item)) * ((count - 1) * 2 / 3) + (prices.fetch(item)))
# elsif (count > 3 && count % 3 == 2)
#   total += ((prices.fetch(item)) * ((count - 2) * 2 / 3) + (prices.fetch(item)) * 2)
# end
