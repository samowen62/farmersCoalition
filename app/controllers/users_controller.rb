class UsersController < ApplicationController

	before_filter :save_login_state, :only => [:new, :create]

	def new
		@user = User.new
	end

	def show
		#validate session here as well
    	@user = User.find(params[:id])
  	end

	def create
		#render plain: params[:user].inspect
		@user = User.new(user_params)
		if @user.save
			flash[:notice] = "You signed up successfully"
			flash[:color]= "valid"
		else
			flash[:notice] = "Form is invalid"
			flash[:color]= "invalid"
		end 
  		render "new"
	end

	def edit
  		@article = Article.find(params[:id])
	end

	private
	  def user_params
	    params.require(:user).permit(:name, :city, :email, :password)
	  end
end
