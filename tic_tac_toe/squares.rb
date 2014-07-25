require_relative 'player'
require_relative 'board'

class Squares
	def initialize(name)
		@name = name
		@contents = " "
		@full = false
	end
	
	def fill(symbol)
		@full = true
		@contents = "#{symbol}"
	end

	def status
		@full
	end

	def contents
		@contents
	end	
end			