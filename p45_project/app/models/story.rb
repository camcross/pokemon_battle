class Story < ActiveRecord::Base
	require 'csv'

	require 'json'
	require 'rest_client'

	belongs_to :user, :foreign_key => :user_id

	#sanitize the csv for each feature story
	def self.sanitize_type
		sanitized_type_csv = []
		CSV.foreach('data.csv', :headers => true) do |csv_obj|
			if csv_obj['Type'] == "feature"
				sanitized_type_csv << csv_obj['Title']
			end
		end
		sanitized_type_csv
	end


	#sanitize the csv for unstarted, started, and iceboxed stories
	def self.sanitize_current_state
		sanitized_current_state_csv = []
		CSV.foreach('data.csv', :headers => true) do |csv_obj|
			if (csv_obj['Current State'] == "started") || (csv_obj['Current State'] == "unstarted")
				sanitized_current_state_csv << csv_obj['Title']
			end
		end
		sanitized_current_state_csv
	end

	#sanitize the csv for type and state and return the clean results
	def self.sanitize_csv
		sanitized_csv = []
		sanitized_type = self.sanitize_type
		sanitized_current_state = self.sanitize_current_state
		sanitized_csv = sanitized_type & sanitized_current_state
	end


	#Reads from the CSV
	def self.grade_length(stories_to_grade)

		#array of each stories grade individually
		total_length_grade = []
		failed_length_stories = []

		#need to change this so that any csv can be read/replace with variable
		stories_to_grade.each do |story|

			#check for enough words/too many words and grade accordingly
			if story.split.size < 6
				total_length_grade << "F"
				failed_length_stories << story
			elsif story.split.size > 50
				total_length_grade << "F"
				failed_length_stories << story
			else
				total_length_grade << "A"
			end
		end

		percent_length_grade = (((total_length_grade.count("A"))/(total_length_grade.size).to_f) * 100).to_i
		
		length_data = {:percent_grade => percent_length_grade,
			:failed_stories => failed_length_stories}
	end


	def self.grade_value(stories_to_grade)

		#array of each stories value grade individually
		total_value_grade = []
		failed_value_stories = []

		stories_to_grade.each do |story|

			#check for 'so that' clause and grade accordingly
			if story.downcase.include?("so that") 
				total_value_grade << "A"
			elsif story.downcase.split.include?("so") 
				total_value_grade << "A"
			elsif story.downcase.include?("in order to") 
				total_value_grade << "A"
			else
				total_value_grade << "F"	
				failed_value_stories << story
			end

			story.partition("so that")
		end
		percent_value_grade = (((total_value_grade.count("A"))/(total_value_grade.size).to_f) * 100).to_i

		value_data = {:percent_grade => percent_value_grade,
						:failed_stories => failed_value_stories}
	end

	#This method checks to make sure that the value section of the story is at least 1/3 the total story length
	def self.grade_value_length(stories_to_grade)

		total_value_length_grade = []
		failed_value_length_stories = []

		stories_to_grade.each do |story|

			#check for 'so that' clause and grade accordingly
			story_parts = story.partition("so that")
			value_ratio = (story_parts[2].length/story.length.to_f)
			if value_ratio < 0.33
				total_value_length_grade << "F"
				failed_value_length_stories << story
			else
				total_value_length_grade << "A"	

			end
		end	
		percent_value_length_grade = (((total_value_length_grade.count("A"))/(total_value_length_grade.size).to_f) * 100).to_i

		value_length_data = {:percent_grade => percent_value_length_grade,
						:failed_stories => failed_value_length_stories}
	end

	def self.grade_role(stories_to_grade)

		#array of each stories value grade individually
		total_role_grade = []
		failed_role_stories = []

		stories_to_grade.each do |story|

			#check for 'so that' clause and grade accordingly
			if story.downcase.include?("as a") 
				total_role_grade << "A"
			elsif story.downcase.include?("user")
				total_role_grade << "A" 
			elsif story.downcase.include?("admin")
				total_role_grade << "A"
			elsif story.downcase.include?("a * must")
				total_role_grade << "A"
			elsif story.downcase.split.include?("i")
				total_role_grade << "A"
			else
				total_role_grade << "F"	
				failed_role_stories << story

			end
		end
		percent_role_grade = (((total_role_grade.count("A"))/(total_role_grade.size).to_f) * 100).to_i

		role_data = {:percent_grade => percent_role_grade,
						:failed_stories => failed_role_stories}
	end

	def self.grade_goal(stories_to_grade)
		total_goal_grade = []
		failed_goal_stories = []

		stories_to_grade.each do |story|
			if story.downcase.include?("i want")
				total_goal_grade << "A"
			elsif story.downcase.include?("i should")
				total_goal_grade << "A"
			elsif story.downcase.include?("i would")
				total_goal_grade << "A"
			elsif story.downcase.include?("when i")
				total_goal_grade << "A"
			elsif story.downcase.include?("i need")
				total_goal_grade << "A"
			else
				total_goal_grade << "F"
				failed_goal_stories << story
			end
		#array of each stories value grade individually
		end
		percent_goal_grade = (((total_goal_grade.count("A"))/(total_goal_grade.size).to_f) * 100).to_i

		goal_data = {:percent_grade => percent_goal_grade,
						:failed_stories => failed_goal_stories}

	end

	def self.grade_clarity(percent_value, percent_value_length, percent_role, percent_goal)
		weighted_value = (percent_value * 0.25) + (percent_value_length * 0.25) 
		weighted_role = percent_role * 0.25
		weighted_goal = percent_goal * 0.25

		clarity_score = (weighted_value + weighted_role + weighted_goal)
	end


	#list the worst offending stories that lack a role, goal, and value.
	def self.worst_stories(value, role, goal)
		intersection = value & role
		worst = intersection & goal
	end

	#pulls user projects with provided api key with pivotal tracker api
	def self.pivotal_tracker_stories(api_key)
		projects_stories = {}
		projects_response = RestClient.get('https://www.pivotaltracker.com/services/v5/projects', :'X-TrackerToken' => api_key)
		
		project_id = nil
		projects_parse = JSON.parse(projects_response)
		projects_parse.each do |project|
				project_id = project["id"]
				stories_response = RestClient.get("https://www.pivotaltracker.com/services/v5/projects/#{project_id}/stories?filter=type%3Afeature+AND+-state%3Afinished", :'X-TrackerToken' => api_key)
				stories_parse = JSON.parse(stories_response)
				stories_parse

				projects_stories["#{project["name"]}"] = stories_parse
			end
		
		projects_stories
	end

	#takes out user stories from project
	def self.clean_stories(stories_hash, project)
		stories_to_grade = []
		stories_hash[project].each do |story|
			stories_to_grade << story["name"]
		end
		stories_to_grade
	end

	
end