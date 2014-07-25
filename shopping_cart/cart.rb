require_relative 'item'
require_relative 'shopper'

class Cart
  
  def initialize
    @items = []
    @total_price = 0
    @full = false
  end

  # @return{Array<Item>}
  #   The items and their quantities in the cart, keyed by item name.
  def items
    @items
  end

  def empty
    @full = false
    @items =[]
  end
  # @return{float} The total price of all the goods in the cart.
  def total_price
    @items.each do |item|
      @total_price += item.price
    end
    @total_price.round(2)
  end

  # @param{Item} item The item to add. 
  def add(item)
    @items.push(item)
  end

  # @param{Item} item The item to remove. 
  def remove(item)
    @items.delete(item)
  end
end