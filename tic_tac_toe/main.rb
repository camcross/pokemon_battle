require_relative 'player'
require_relative 'squares'
require_relative 'board'

puts "Welcome to Tic-Tac-Toe!"

continue = true

# board = Board.new()
# puts board

puts "Player One, please enter your name: "
input = gets.chomp
p_one = Player.new(input, "X", true)
puts "Welcome, #{p_one.name}!"

puts "\nPlayer Two, please enter your name: "
input = gets.chomp
p_two = Player.new(input, "O", false)
puts "Welcome, #{p_two.name}!"

board = Board.new()

while (true && continue)
	if (p_one.turn && continue)
		puts "#{p_one.name}: "
		input = gets.chomp
		square = board.grid[":#{input}"]
		if(input.to_i > 0 && input.to_i < 10)
			square = board.grid[":#{input}"]
			if (input.to_i < 0 || input.to_i > 9)
				puts "Error: Invalid input"
				puts "#{p_one.name}: "
				input = gets.chomp
				square = board.grid[":#{input}"]
				square.fill(p_one.symbol)
				p_one.add(board.grid[":#{input}"])
			elsif(square.status)
				puts "Error, square already taken"	
				puts "#{p_one.name}: "
				input = gets.chomp
				square = board.grid[":#{input}"]
				square.fill(p_one.symbol)
				p_one.add(board.grid[":#{input}"])
			elsif(input.to_i > 0 && input.to_i < 10)
				square = board.grid[":#{input}"]
				square.fill(p_one.symbol)
				p_one.add(board.grid[":#{input}"])
			end	
		
		end	
	end	
	puts board.print
	if (((p_one.current_squares.include?(board.grid[":1"]) && p_one.current_squares.include?(board.grid[":2"]) && p_one.current_squares.include?(board.grid[":3"])) || (p_one.current_squares.include?(board.grid[":4"]) && p_one.current_squares.include?(board.grid[":5"]) && p_one.current_squares.include?(board.grid[":6"])) || (p_one.current_squares.include?(board.grid[":7"]) && p_one.current_squares.include?(board.grid[":8"]) && p_one.current_squares.include?(board.grid[":9"])) || (p_one.current_squares.include?(board.grid[":1"]) && p_one.current_squares.include?(board.grid[":4"]) && p_one.current_squares.include?(board.grid[":7"])) || (p_one.current_squares.include?(board.grid[":2"]) && p_one.current_squares.include?(board.grid[":5"]) && p_one.current_squares.include?(board.grid[":8"])) || (p_one.current_squares.include?(board.grid[":3"]) && p_one.current_squares.include?(board.grid[":6"]) && p_one.current_squares.include?(board.grid[":9"])) || (p_one.current_squares.include?(board.grid[":1"]) && p_one.current_squares.include?(board.grid[":5"]) && p_one.current_squares.include?(board.grid[":9"])) || (p_one.current_squares.include?(board.grid[":3"]) && p_one.current_squares.include?(board.grid[":5"]) && p_one.current_squares.include?(board.grid[":7"]))))
			puts "#{p_one.name} wins!"
			continue = false
	end	
	if (p_two.turn && continue)
		puts "#{p_two.name}: "
		input = gets.chomp
		square = board.grid[":#{input}"]
		if (input.to_i < 0 || input.to_i > 9)
			puts "Error: Invalid input"
			puts "#{p_two.name}: "
			input = gets.chomp
			square.fill(p_two.symbol)
			p_one.add(board.grid[":#{input}"])
		elsif (square.status)
			puts "Error, square already taken"	
			puts "#{p_two.name}: "
			input = gets.chomp
			square = board.grid[":#{input}"]
			square.fill(p_two.symbol)
			p_one.add(board.grid[":#{input}"])
		elsif(input.to_i > 0 && input.to_i < 10)
			square = board.grid[":#{input}"]
			square.fill(p_two.symbol)
			p_two.add(board.grid[":#{input}"])
		end	
	end	
	p_one.swap_turn
	p_two.swap_turn
end		