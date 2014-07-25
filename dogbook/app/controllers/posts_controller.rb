class PostsController < ApplicationController
	
	def index
		@posts = Post.all
	end	

	def new
		@post = Post.new
		# set_name
	end	

	def destroy
		@post = Post.find(params[:id])
		@post.destroy
		redirect_to posts_path
	end	

	def create
		@post = Post.new(post_params)
		if @post.save
			redirect_to :action => :index
		else
			# set_name
			render :new	
		end	
	end

	def show
		@post = Post.find(params[:id])
	end
	
	def post_params
		params.require(:post).permit(:body, :user_id)
	end		

	# def set_name
	# 	@name = {}
	# 	User.all.each {|name| @users[user.name] = user.id}
	# end	
end	