class CreatePokemon < ActiveRecord::Migration
  def change
    create_table :pokemons do |t|
    	t.integer :national_dex_id
    	t.string :name

    	
    end
  end
end
