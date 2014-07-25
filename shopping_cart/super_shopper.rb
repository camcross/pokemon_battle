require_relative 'item'
require_relative 'cart'

class SuperShopper
		def initialize(first, last)
			@first_name = first
			@last_name = last
			@money = 100
			@full_name = first + last
			@cart = Cart.new()
		end
		
		def first_name
			@first_name
		end		

		def last_name
			@flast_name
		end		

		def full_name
			@full_name
		end		

		def money
			@money
		end		

		def cart
			@cart
		end	

		def checkout
			if (self.money > @cart.total_price)
				@money -= (0.9 * @cart.total_price)
				@cart.empty
			end
		end		
end	
