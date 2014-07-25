# require_relative 'squares'
# require_relative 'board'

class Player
	def initialize(name, symbol, turn)
		@name = name
		@symbol = symbol
		@turn = turn
		@squares = []
		@win = false
	end

	def name
		@name
	end	

	def symbol
		@symbol
	end	
	
	def turn
		@turn
	end
	
	def swap_turn
		@turn ^= true
	end

	def add(square)
		@squares.push(square)
	end
	
	def current_squares
		@squares
	end		

	def win
		@win = true
	end
	
	def win_value
		@win
	end		
end				