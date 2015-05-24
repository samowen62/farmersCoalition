class ProfileController < ApplicationController

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

  def update_visitor_count
    if user_is_logged_in?
      unless (profile = Profile.where(user_id: session[:user_id]).first).nil?
        EntryPoint.where(profile_id: profile.id, period: params[:period], int_day: params[:day]).destroy_all

        for d in params[:points] do
          p = EntryPoint.new(profile_id: profile.id, period: params[:period], int_day: params[:day])
          p[:start] = d[:start]
          p[:end] = d[:end]
          p[:count] = d[:count]
          p[:ptNum] = d[:ptNum]
          p.save!
        end
      end
    end
    
    render plain: "done"
  end

  def update_visitor_survey
    list = ["home_zip","bikes","walking","bus","taxi","other_method","every_week","every_other_week", "every_month","less_than_month", "spent_morning","spent_afternoon", "downtown_spent_morning","downtown_spent_afternoon","lettuces","roots","tomatoes","corn","melons","berries"]
    doubleList = ["spent_morning", "downtown_spent_morning"]
    radioList = [28, 13, 36, 7]

    if user_is_logged_in?
      unless (profile = Profile.where(user_id: session[:user_id]).first).nil?

        unless (survey = VisitorSurvey.where(date: params[:date]).where(profile_id: profile.id).first).nil?
          for i in list
            if doubleList.include?(i)
              survey[i] += params[i] ? params[i].to_f : 0
            else
              if i == "home_zip"
                survey[i] += params[i] ? "#{params[i]};" : ""
              else  
                survey[i] += params[i] ? 1 : 0
              end
            end
          end

          for i in radioList
            if survey ["yes#{i}"].nil?
              survey["yes#{i}"] = 0
            else
              survey ["yes#{i}"] += params["yes#{i}"] == 'true' ? 1 : 0
              survey ["no#{i}"] += params["yes#{i}"] == 'false' ? 1 : 0
            end
          end

          food = params[:food]
          food.each do |k,v|
            if(v)
              survey[k] += 1
            end
          end
          survey.save!

        else
          survey = VisitorSurvey.new
          survey[:date] = params[:date]
          survey[:profile_id] = profile.id

          for i in list
            if doubleList.include?(i)
              survey[i] = params[i] ? params[i].to_f : 0
            else 
              if i == "home_zip"
                survey[i] = params[i] ? "#{params[i]};" : ""
              else 
                survey[i] = params[i] ? 1 : 0
              end
            end
          end

          for i in radioList
            survey ["yes#{i}"] = params["yes#{i}"] == 'true' ? 1 : 0
            survey ["no#{i}"] = params["yes#{i}"] == 'false' ? 1 : 0
          end
          
          food = params[:food]
          food.each do |k,v|
            survey[k] = v ? 1 : 0
          end

          survey.save!
        end
        render plain: survey.inspect
        return
      end
    end
    render plain: "error"
  end

  def update_sales_slip

    if user_is_logged_in?
      #slip = SalesSlip.new(sales_params)
      #render plain: params.inspect
      #return
      unless (profile = Profile.where(user_id: session[:user_id]).first).nil?
        if (slip = SalesSlip.where(date: params[:date]).where(profile_id: profile.id).first).nil?
          slip = SalesSlip.new(sales_params)
          slip[:date] = params[:date]
          slip[:profile_id] = profile.id
          slip.save!

          render plain: slip.inspect
          return
        else
          slip.update_attributes!(sales_params)
          slip.save!

          render plain: slip.inspect
          return
        end
      end
    end
    render plain: "error"
  end

  def create_man
    #render plain: "#{session[:_csrf_token]} | #{params[:authenticity_token]}"
    #return
    if user_is_logged_in?
      #could do it with find but an exeption will be thrown if not found
      unless (profile = Profile.where(user_id: session[:user_id]).first).nil?
        params[:positions] = 0;

        unless  params[:pos].nil?
          for i in 0..11
            if params[:pos][i]
              params[:positions] += 2 ** i
            end
          end
        end

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
    #render plain: "not logged in #{session[:_csrf_token]} #{params[:authenticity_token]}"
    #return 
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

  def create_metrics
    if user_is_logged_in?
      unless (profile = Profile.where(user_id: session[:user_id]).first).nil?
        metrics_1 = 0;
        metrics_2 = 0;

        metrics = params[:_json]

        unless  metrics.nil?
          for i in 0..37
            if metrics[i]
              if i < 20 # 0-19 in metrics_1
                metrics_1 += 2 ** i
              else
                metrics_2 += 2 ** (i - 20)
              end
            end
          end
        end

        profile[:metrics_1] = metrics_1
        profile[:metrics_2] = metrics_2

        profile.save!
        render plain: profile.inspect
        return
      end
    end
    return
  end

  private
  	def profile_params 
  		params.require(:profile).permit(:name, :city, :address, :state, :county, :year, :year_round, :multiple_locs, :FMC_member, :host_name, :other_associations, :mission_statement, :ms_website, :ms_manual, :ms_market_promos, :ms_none, :ms_other, :ms_other_text, :when_ms, :person_decisions, :list_of_persons, :logo_path, :incorporated_other, :incorporated, :zip)
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

  private
    def sales_params
      params.permit(:date, :total_sales,:farm_sales,:value_sales,:ready_sales, :WIC_FMNP_sales,:WIC_sales,:Senior_FMNP_sales,:Debt_sales,:SNAP_sales,:SNAP_transactions,:pounds_donated, :values_donated, :veg1, :veg2, :veg3)
    end
  #private
   # def survey_params
    #  params.permit(
     #   )
    #end
end
