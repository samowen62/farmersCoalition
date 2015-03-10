class UsersController < ApplicationController

	before_filter :save_login_state, :only => [:new, :create]

	def new
		@user = User.new
	end

	def show
		if user_is_logged_in?
    		@user = User.find(session[:user_id])
    		@profile = Profile.where(user_id: session[:user_id]).first
    	else 
    		render "new"
    	end
  	end

	def create
		#render plain: params[:user].inspect
		if params[:user][:password] != params[:user][:password_confirmation]
			render "new"
			return
		end

		@user = User.new(user_params)
		if @user.save
			flash[:notice] = "You signed up successfully"
			flash[:color]= "valid"
		else
			flash[:notice] = "Form is invalid"
			flash[:color]= "invalid"
		end 
  		render "show"
	end

	def edit
  		@article = Article.find(params[:id])
	end

	private
	  def user_params
	    params.require(:user).permit(:email, :password , :password_confirmation)
	  end
end
