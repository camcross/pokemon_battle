# Tests for Shopping Cart exericise
# By Rafi / June 1, 2014

# Color outputs on *nix terminals
module Color
  # shamelessly stolen (and modified) from redgreen
  COLORS = {
    :clear   => 0,  :black   => 30, :red   => 31,
    :green   => 32, :yellow  => 33, :blue  => 34,
    :magenta => 35, :cyan    => 36,
  }
  module_function

  COLORS.each do |color, value|
    module_eval "def #{color}(string); colorize(string, #{value}); end"
    module_function color
  end

  def colorize(string, color_value)
    "\e[#{color_value}m" + string + "\e[#{COLORS[:clear]}m"
  end
end

# Helper methods

def pass(msg)
  puts "    " + Color.green(msg)
end

def fail(msg)
  puts Color.red msg
  exit
end

def assert(condition, s_msg, f_msg)
  if condition
    pass s_msg
  else
    fail f_msg
  end
end

# Test begins

require_relative 'item'
require_relative 'cart'

puts Color.blue "Tests for Item"
begin
  milk = Item.new("milk", 1.2)
  eggs = Item.new("eggs", 1.3)
  pass "Create item: works with 2 parameters"
rescue
  fail "Create item: fails with 2 parameters"
end

begin
  milk = Item.new()
  fail "Create item: constructor should require parameters"
rescue
  pass "Create item: constructor fails with no parameters"
end

begin
  assert (milk.name == "milk"), "Item: name method works",
    "Item: bad name method"
rescue
  fail "Item: bad name method"
end

begin
  assert (milk.price == 1.2), "Item: price method works",
    "Item: bad price method"
rescue
  fail "Item: bad price method"
end

puts Color.blue "Tests for Cart"
begin
  cart = Cart.new
  pass "Create cart: works with no parameters"
rescue
  fail "Create cart: fails with no parameters"
end

begin
  cart.items
  pass "Cart: can access items"
  assert cart.items == [], "Cart: items starts as empty array",
    "Cart: items does not start as empty array"
rescue
  fail "Cart: cannot access items"
end

begin
  cart.add(milk)
  pass "Cart: has add method"
rescue
  fail "Cart: has bad add method"
end

test = (cart.items == [milk])
assert test, "Cart: add works first time", "Cart: add fails first time"

3.times { cart.add(milk) }

test = (cart.items == [milk, milk, milk, milk])
assert test, "Cart: add works subsequent times",
  "Cart: add fails subsequent first times"

cart.add(eggs)
test = (cart.items == [milk, milk, milk, milk, eggs])
assert test, "Cart: add works with second item",
  "Cart: add fails with second item"

begin
  cart.remove(milk)
  pass "Cart: has remove method"
rescue
  fail "Cart: has bad remove method"
end

test = (cart.items == [eggs])
assert test, "Cart: remove works when item exists",
  "Cart: remove fails when item exists"

cart.remove(eggs)
begin 
  cart.remove(eggs)
  test = (cart.items == [])
  assert test, "Cart: remove works when quantity is 0",
    "Cart: remove ends with wrong quantity when quantity is originally 0"
rescue
  fail "Cart: remove fails when quantity is 0"
end

price_fail_msg = "Cart: total_price is incorrect" +
  "(you may have to use the round method on your final answer)"

3.times { cart.add(milk) }
begin
  fail price_fail_msg unless cart.total_price == 3.6
rescue
  fail "Cart: bad total_price method"
end

2.times do
  cart.add(eggs)
end

fail price_fail_msg unless cart.total_price == 6.20

pass "Cart: total_price works!"

puts
puts Color.blue("Congratulations, all tests passed!")
puts
