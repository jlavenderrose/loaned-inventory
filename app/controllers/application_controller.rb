class ApplicationController < ActionController::Base
	protect_from_forgery
	layout 'application'

	before_filter :check_sign_in
 
	def current_user
		@current_user ||= Administrator.find_by_remember_token(session[:user_token]) if session[:user_token]
		@current_user
	end
  
	def check_sign_in
		if current_user.nil? then
			flash[:info] = "You're not logged in!"
			redirect_to login_path
		end
	end
end
