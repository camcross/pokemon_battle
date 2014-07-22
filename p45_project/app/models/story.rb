class Story < ActiveRecord::Base
	require 'csv'
	belongs_to :user, :foreign_key => :user_id

	#Reads from the CSV
	def self.grade

		total_grade = []
		CSV.foreach('data.csv', :headers => true) do |csv_obj|


			if csv_obj['Title'].split.size < 6
				total_grade << "F"
			elsif csv_obj['Title'].split.size > 50
				total_grade << "F"
			else
				total_grade << "A"
			end
		end
		total_grade
	end
end