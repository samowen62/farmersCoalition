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
    #render plain: params.inspect
    #return
    if user_is_logged_in?
      #could do it with find but an exeption will be thrown if not found
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
          management[:profile_id] = profile.id
          management.save!
          render plain: management.inspect
          return
        end
      end
    end
    render plain: "not logged in"
    return 
  end

  def create_access
    if user_is_logged_in?
      unless (profile = Profile.where(user_id: session[:user_id]).first).nil?
        unless (accessibility = Accessibility.where(profile_id: profile.id).first).nil?
          accessibility.update_attributes!(access_params)
          accessibility.save!
          render plain: accessibility.inspect
          return
        else
          #because this horseshit doesn't work for some reason
          #accessibility = profile.accessibility.create(access_params)
          accessibility = Accessibility.new(access_params)
          accessibility[:profile_id] = profile.id
          accessibility.save!
          render plain: accessibility.inspect
          return
        end
      end
    end
  end

  def create_communities
    if user_is_logged_in?
      unless (profile = Profile.where(user_id: session[:user_id]).first).nil?
        unless (communities = Community.where(profile_id: profile.id).first).nil?
          communities.update_attributes!(community_params)
          communities.save!
          render plain: communities.inspect
          return
        else
          communities = Community.new(community_params)
          communities[:profile_id] = profile.id
          communities.save!
          render plain: communities.inspect
          return
        end
      end
    end
  end

  private
  	def profile_params 
  		params.require(:profile).permit(:name, :city, :address, :state, :county, :year, :year_round, :multiple_locs, :FMC_member, :host_name, :other_associations, :mission_statement, :ms_website, :ms_manual, :ms_market_promos, :ms_none, :ms_other, :ms_other_text, :when_ms, :person_decisions, :list_of_persons, :logo_path, :incorporated_other, :incorporated)
  	end

  private
    def management_params 
      params.permit(:num_staff, :positions, :other, :ave_unpaid_market, :ave_unpaid_non_market, :ave_paid_market, :ave_paid_non_market, :annual_budget_for_staff, :annual_operating_budget, :bookKeeper, :other_rules, :other_rules_path, :annual_application_fee, :annual_membership_fee, :percentage_sales, :no_charge, :other_charge, :other_charge_explained, :ave_num_vendors)
    end

  private
    def access_params 
      params.permit(:other_features, :other_features_explain, :bus_sub, :bike_racks, :sidewalks, :free_parking, :roof, :other_access, :other_access_explain, :selling_space, :children_activities, :live_music, :food_demonstrations, :restrooms, :restroom_count, :accept_SNAP, :SNAP_offer, :FMNP_available, :accept_FMNP, :FMNP_offer, :FMNP_senior_available, :accept_FMNP_senior, :FMNP_senior_offer, :CVV_available, :accept_CVV, :CVV_offer, :other_vouchers, :other_vouchers_explain, :other_access_features_explain, :SNAP_offer_other, :FMNP_offer_other, :FMNP_senior_offer_other, :CVV_offer_other)
    end

  private
    def community_params 
      params.permit(:profile_id, :created_at, :updated_at, :customers, :municipal, :producers, :extension, :community_groups, :advisors_other, :sponsors, :newsletter, :facebook, :twitter, :google, :pinterest, :online_other, :online_other_explain, :annual_report, :report_link, :experience_collecting, :resources_available)
    end
end
