class StoriesController < ApplicationController

	def index
		@stories = Story.all

		#calculate the length percent_length_grade = Story.grade_length

		#calculate the value grade
		@length_data = []
		@value_data = []
		@value_length_data = []
		@goal_data = []
		@role_data = []
		@clarity_data = []
		@worst_stories = []
		@total_score = []

		@api_key = params[:q]


		@projects_stories = Story.pivotal_tracker_stories(@api_key)

		@projects_stories.each_with_index do |project, index| 
		 	@length_clean = Story.clean_stories(@projects_stories, project[0])

		 	@length_data << Story.grade_length(@length_clean) 
		 	@value_data << Story.grade_value(@length_clean)

			@value_length_data << Story.grade_value_length(@length_clean)

			@goal_data << Story.grade_goal(@length_clean)

			@role_data << Story.grade_role(@length_clean)

			@clarity_data << Story.grade_clarity(@value_data[index][:percent_grade], @value_length_data[index][:percent_grade], 
			@role_data[index][:percent_grade], @goal_data[index][:percent_grade] )

			@worst_stories << Story.worst_stories(@value_data[index][:failed_stories],@role_data[index][:failed_stories], 
			@goal_data[index][:failed_stories])

			@total_score << (@length_data[index][:percent_grade] * 0.5) + (@clarity_data[index] * 0.5).to_i
		end

		

		
	end

	def create
		@story = Story.new
		@story.body = params[:body]
		@story.save
		redirect_to :action => :index
	end
	
	def story_params
		params.require(:story).permit(:body, :q)
	end	

		
end