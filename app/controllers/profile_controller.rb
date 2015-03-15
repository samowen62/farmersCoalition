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
        profile[:year] = params[:profile][:year]
        profile[:multiple_locs] = params[:profile][:multiple_locs]
        profile[:FMC_member] = params[:profile][:FMC_member]
        profile[:host_name] = params[:profile][:host_name]
        profile[:other_associations] = params[:profile][:other_associations]
        profile[:incorporated] = params[:profile][:incorporated]
        profile[:mission_statement] = params[:profile][:mission_statement]
        profile[:ms_website] = params[:profile][:ms_website]
        profile[:ms_manual] = params[:profile][:ms_manual]
        profile[:ms_market_promos] = params[:profile][:ms_market_promos]
        profile[:ms_none] = params[:profile][:ms_none]
        profile[:ms_other] = params[:profile][:ms_other]
        if profile[:ms_other]
          profile[:ms_other_text] = params[:profile][:ms_other_text]
        end
        profile[:when_ms] = params[:profile][:when_ms]
        profile[:person_decisions] = params[:profile][:person_decisions]
        profile[:list_of_persons] = params[:profile][:list_of_persons]
        profile[:logo_path] = params[:profile][:logo_path]
        profile[:incorporated_other] = params[:profile][:incorporated_other]
        profile.save!
      end
      
      redirect_to user_path(@user)

    else 
   		redirect_to root_path
    end

  end

  private
  	def profile_params 
  		params.require(:profile).permit(:name, :city, :address, :state, :county, :year, :multiple_locs, :FMC_member, :host_name, :other_associations, :mission_statement, :ms_website, :ms_manual, :ms_market_promos, :ms_none, :ms_other, :ms_other_text, :when_ms, :person_decisions, :list_of_persons, :logo_path, :incorporated_other)
  	end
end
