require_relative 'shopper'
require_relative 'cart'

class Item
  
  def initialize(name, price)
    @name = name
    @price = price
  end

  def name
    @name
  end

  def price
    @price
  end
end