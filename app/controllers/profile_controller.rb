class ProfileController < ApplicationController
  def index
  end

  #same as update
  def create
  	#render plain: profile_params

  	if user_is_logged_in?
    	@user = User.find(session[:user_id])
      #check if any exist
      if Profile.where(user_id: session[:user_id]).count == 0
      	profile = Profile.new(profile_params)
      	profile.user_id = session[:user_id]
      	profile.save!
      else 
        #there's definitely a better way to do this but I'm lazy right now
        profile = Profile.where(user_id: session[:user_id]).first
        profile[:name] = params[:profile][:name]
        profile[:city] = params[:profile][:city]
        profile[:address] = params[:profile][:address]
        profile[:state] = params[:profile][:state]
        profile[:county] = params[:profile][:county]
        profile[:multiple_locs] = params[:profile][:multiple_locs]
        profile.save!
      end
      
      redirect_to user_path(@user)

    else 
   		redirect_to root_path
    end

  end

  private
  	def profile_params #dont forget to add params down here for new ones
  		params.require(:profile).permit(:name, :city, :address, :state, :county, :multiple_locs)
  	end
end
