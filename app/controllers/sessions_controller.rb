class SessionsController < ApplicationController
	before_filter :authenticate_user, :except => [:index, :login, :login_attempt, :logout]
	before_filter :save_login_state, :only => [:index, :login, :login_attempt]

	def home
		#Home Page
	end

	def profile
		#Profile Page
	end

	def setting
		#Setting Page
	end

	def login
		#Login Form
	end

	def login_attempt
		authorized_user = User.authenticate(params[:username_or_email],params[:login_password])
		if authorized_user
			session[:user_id] = authorized_user.id
			#render plain: session[:user_id].inspect
			#return
			flash[:notice] = "Wow Welcome again, you logged in as #{authorized_user.email}"

			@user = User.find(authorized_user.id)
			render "users/home"

		else
			flash[:notice] = "Invalid Username or Password"
        	flash[:color]= "invalid"
			render "login"	
		end
	end

	def pass_reset
		@user = User.find(session[:user_id])
   		UserMailer.password_email(@user).deliver_now
   		render plain: "death"
   		return
	end

	def logout
		session[:user_id] = nil
		redirect_to :action => 'login'
	end
end
