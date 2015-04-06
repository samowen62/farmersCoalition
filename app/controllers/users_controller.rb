class UsersController < ApplicationController

	before_filter :save_login_state, :only => [:new, :create]

	def new
		@user = User.new
	end

	def show
		if user_is_logged_in?
    		@user = User.find(session[:user_id])
    		@profile = Profile.where(user_id: session[:user_id]).first
    		@markets = @profile.markets
    		@management = @profile.managements
    		@accessibility = @profile.accessibility
    		@positions = Array.new

    		unless  @management.nil?
	    		for i in 0..11
	    			@positions.push(@management.pos(i))
	    		end
	    	end
    		return
    	else 
    		redirect_to root_path
    	end
  	end

  	def display
  		if user_is_logged_in?
    		@user = User.find(session[:user_id])
    		session[:user_id] = @user.id
    		@profile = Profile.where(user_id: session[:user_id]).first
    		@markets = @profile.markets

    	else 
    		redirect_to root_path
    	end
  	end

	def create
		#render plain: params[:user].inspect
		if params[:user][:password] != params[:user][:password_confirmation]
			render "new"
			return
		end

		if params[:user][:password].nil? || params[:user][:password_confirmation].nil?
			render "new"
			return
		end

		@user = User.new(user_params)
		if @user.save!
			session[:user_id] = @user.id
			@profile = Profile.new(:user_id => @user.id)
			@profile.save!
			render "show"
		else
			render "signup"
		end 
  		
	end

	def edit
  		@article = Article.find(params[:id])
	end

	private
	  def user_params
	    params.require(:user).permit(:email, :password , :password_confirmation)
	  end

end
