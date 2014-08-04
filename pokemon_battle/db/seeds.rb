# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'rest_client'
require 'json'

1.upto(9) do |num|
	response = RestClient.get("http://pokeapi.co/api/v1/pokemon/#{num}")
	parse = JSON.parse(response)
	Pokemon.create("name" => parse["name"], "national_dex_id" => parse["national_id"])
end