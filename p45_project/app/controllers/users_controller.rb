class UsersController < ApplicationController

	def index
		@users = User.all
	end

	def create
		@user = User.new
		@user.name = params[:name]
		redirect_to :action => :index
		@user.save
	end
	
	def user_params
		params.require(:user).permit(:name)
	end	
end