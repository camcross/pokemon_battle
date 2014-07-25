class User < ActiveRecord::Base
	has_many :posts
	after_create :send_user_created_email

	protected

	def send_user_created_email
		UserMailer.welcome_email(self).deliver
		puts "Hayyyy!"
	end 
end	