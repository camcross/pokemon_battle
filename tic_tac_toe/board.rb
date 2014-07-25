require_relative 'squares'
require_relative 'player'

class Board
	def initialize
		@grid = {
			":1" => Squares.new("square_one"), ":2" => Squares.new("square_two"), ":3" => Squares.new("square_three"),
			":4" => Squares.new("square_four"), ":5" => Squares.new("square_five"), ":6" => Squares.new("square_six"),
			":7" => Squares.new("square_seven"), ":8" => Squares.new("square_eight"), ":9" => Squares.new("square_nine")
		}
		@winners = [
			[":1", ":2", ":3"],
			[":4", ":5", ":6"],
			[":7", ":8", ":9"],
			[":1", ":4", ":7"],
			[":2", ":5", ":8"],
			[":3", ":6", ":9"],
			[":1", ":5", ":9"],
			[":3", ":5", ":7"],
		]
		a1 = " "
		a2 = " "
		a3 = " "
		a4 = " "
		a5 = " "
		a6 = " "
		a7 = " "
		a8 = " "
		a9 = " "
	end

	#use this to sum the values of -1, 0 and 1 in each given win area
	def winners(i)
		@winners[i]
	end	

	def set_contents
		@s1 = @grid[":1"].contents
		@s2 = @grid[":2"].contents
		@s3 = @grid[":3"].contents
		@s4 = @grid[":4"].contents
		@s5 = @grid[":5"].contents
		@s6 = @grid[":6"].contents
		@s7 = @grid[":7"].contents
		@s8 = @grid[":8"].contents
		@s9 = @grid[":9"].contents
	end	

	def grid
		@grid
	end	

	def show_winners
		@winners
	end	

	def fill_square(i)
		ai = @grid[i].contents
	end	
	
	def winner (player)
		if(player.current_squares.eql?(@winners[0]) || player.current_squares.eql?(@winners[1]) || player.current_squares.include?(@winners[2]) 	|| player.current_squares.include?(@winners[3]) || player.current_squares.include?(@winners[4]) || player.current_squares.include?(@winners[5]) || player.current_squares.include?(@winners[6]) || player.current_squares.include?(@winners[7]))
		true
		end
	end		

	def print
		puts
						"
					             |   |  
						  ———+———+———
					             |   |   
						  ———+———+———
						     |   |    
						              "
	end					 
end

