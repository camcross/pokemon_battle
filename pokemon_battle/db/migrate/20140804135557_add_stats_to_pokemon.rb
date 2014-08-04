class AddStatsToPokemon < ActiveRecord::Migration
  def change
  	change_table :pokemons do |t|
    	t.integer :attack
    	t.integer :defense
    	t.integer :hp
    	t.integer :speed
    	t.timestamps
  		end
	end
end