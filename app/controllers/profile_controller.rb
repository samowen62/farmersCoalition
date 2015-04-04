class ProfileController < ApplicationController
  def index
  end

  #same as update
  def create
  	if user_is_logged_in?
    	@user = User.find(session[:user_id])
      #check if any exist
      if Profile.where(user_id: session[:user_id]).count == 0
      	profile = Profile.new(profile_params)
      	profile.user_id = session[:user_id]
      	profile.save!
      else 
        profile = Profile.where(user_id: session[:user_id]).first   
        profile.update_attributes!(profile_params)
        profile.save!
        
        redirect_to "/display"
        return
      end
      
      redirect_to user_path(@user)

    else 
   		redirect_to root_path
    end

  end

  def create_man
    if user_is_logged_in?
      unless (profile = Profile.where(user_id: session[:user_id]).first).nil?
        params[:positions] = 0;

        unless  params[:pos].nil?
          for i in 0..11
            if params[:pos][i] == "true"
              params[:positions] += 2 ** i
            end
          end
        end

        #render plain: profile.managements.inspect;
        #return

        unless (management = Managements.where(profile_id: profile.id).first).nil?
          management.update_attributes!(management_params)
          management.save!
          render plain: management.inspect
          return
        else
          management = Managements.new(management_params)
          management.save!
          render plain: management.inspect
          return
        end
      end
    end
  end

  private
  	def profile_params 
  		params.require(:profile).permit(:name, :city, :address, :state, :county, :year, :year_round, :multiple_locs, :FMC_member, :host_name, :other_associations, :mission_statement, :ms_website, :ms_manual, :ms_market_promos, :ms_none, :ms_other, :ms_other_text, :when_ms, :person_decisions, :list_of_persons, :logo_path, :incorporated_other)
  	end

  private
    def management_params 
      params.permit(:num_staff, :positions, :other, :ave_unpaid_market, :ave_unpaid_non_market, :ave_paid_market, :ave_paid_non_market, :annual_budget_for_staff, :annual_operating_budget, :bookKeeper, :other_rules, :other_rules_path, :annual_application_fee, :annual_membership_fee, :percentage_sales, :no_charge, :other_charge, :other_charge_explained, :ave_num_vendors)
    end
end
