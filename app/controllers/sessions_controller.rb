class SessionsController < ApplicationController
	skip_before_filter :check_sign_in, :except => [:destroy]

	def new
	end

	def create
		user = Administrator.find_by_username(params[:session][:username])
		if user && user.authenticate(params[:session][:password]) then
			session[:user_token] = user.remember_token
			redirect_to root_path
		else
			flash.now[:error] = "Invalid Username/Password combination"
			render 'new'
		end
	end

	def destroy
		if (current_user.nil?) then
			flash[:info] = "You're not logged in!"
			redirect_to root_path
		else
			session[:user_token] = nil
			flash[:info] = "You've been logged out!"
			redirect_to login_path
		end
	end
end
