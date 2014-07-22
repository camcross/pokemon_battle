class StoriesController < ApplicationController

	def index
		@stories = Story.all
		@total_grade = Story.grade
		@grade = Story.grade
	end

	def create
		@story = Story.new
		@story.body = params[:body]
		@story.user_id = current_user.id
		@story.save
		redirect_to :action => :index
	end
	
	def story_params
		params.require(:story).permit(:body)
	end	
end