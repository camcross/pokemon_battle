require_relative 'item'
require_relative 'cart'
require_relative 'super_shopper'

super_shopper = SuperShopper.new("Cam", "Cross",)
cart = super_shopper.cart

milk = Item.new("milk", 50.0)
eggs = Item.new("eggs", 25.0)
bars = Item.new("bars", 10.0)

cart.add(milk)
cart.add(eggs)
cart.add(bars)

puts "#{super_shopper.cart.items}"
puts "#{cart.total_price}"







