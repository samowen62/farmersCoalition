class ProfileController < ApplicationController
  def index
  end

  #def new
  #  @profile = Profile.new
  #end

  def create
  	#render plain: params[:profile].inspect
  	if user_is_logged_in?
    	@user = User.find(session[:user_id])

    	#render plain: @user.profiles.inspect
    	@profile = Profile.new(profile_params)
    	@profile.user_id = session[:user_id]
    	@profile.save!
    	redirect_to user_path(@user)
    	#render plain: @user.profiles.inspect
		#return;
	else 
   		redirect_to root_path
    end
  end

  private
  	def profile_params
  		params.require(:profile).permit(:name)
  	end
end
