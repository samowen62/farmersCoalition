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
        
        render plain: "done"
        return
      end
      
      render plain: "done"
      return
    else 
      render plain: "done"
      return
   		#redirect_to root_path
    end

  end

  def update_visitor_count
    profile = nil

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

        profile.day1 = params[:day1]
        profile.day2 = params[:day2]
        profile.day3 = params[:day3]
        profile.day4 = params[:day4]
        profile.save!
      end
    end
    
    render plain: profile.to_json
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

  def update_food_assistance
    if user_is_logged_in?
      unless (profile = Profile.where(user_id: session[:user_id]).first).nil?
        if params[:id] == -1
          food = FoodAssistance.new(food_params)
          food[:profile_id] = profile.id
          food.save!

          render plain: FoodAssistance.where(profile_id: profile.id).to_json
          return
        else
          food = FoodAssistance.where(profile_id: profile.id).where(id: params[:id]).first
          food.update_attributes!(food_params)
          food.save!

          render plain: FoodAssistance.where(profile_id: profile.id).to_json
          return
        end
      end
    end
    render plain: "error"
  end

  def post_credit_sales
    if user_is_logged_in?
      unless (profile = Profile.where(user_id: session[:user_id]).first).nil?
        if params[:id] == -1
          sale = CreditSales.new(credit_params)
          sale[:profile_id] = profile.id
          sale.save!

          render plain: CreditSales.where(profile_id: profile.id).to_json
          return
        else
          sale = CreditSales.where(profile_id: profile.id).where(id: params[:id]).first
          sale.update_attributes!(credit_params)
          sale.save!

          render plain: CreditSales.where(profile_id: profile.id).to_json
          return
        end
      end
    end
    render plain: "error"
  end

  def post_misc_research
    if user_is_logged_in?

      #  params[:_json].each do |d|
      #    d.delete("$$hashKey")
      #    render plain: d.inspect
      #    return
      #  end

      unless (profile = Profile.where(user_id: session[:user_id]).first).nil?
        params[:_json].each do |d|
          unless d.has_key?("id")
            #mr = MiscResearch.new(misc_research_params)
            mr = MiscResearch.new()
            d.delete("$$hashKey")
            d.each { |key, value| mr[key] = value }
            mr[:profile_id] = profile.id
            mr.save!
          else
            mr = MiscResearch.where(profile_id: profile.id).where(id: d[:id]).first
            d.delete("$$hashKey")
            d.each { |key, value| mr[key] = value }
            mr.save!
          end
        end
      end
    end
    render plain: "error"
  end

  def post_food_list

  end

  def post_market_program
    if user_is_logged_in?
      unless (profile = Profile.where(user_id: session[:user_id]).first).nil?

        if params[:id] == -1
          sale = MarketProgram.new(program_params)
          sale[:profile_id] = profile.id
          sale.save!

          render plain: MarketProgram.where(profile_id: profile.id).to_json
          return
        else
          sale = MarketProgram.where(profile_id: profile.id).where(id: params[:id]).first
          sale.update_attributes!(program_params)
          sale.save!

          render plain: MarketProgram.where(profile_id: profile.id).to_json
          return
        end
      end
    end
    render plain: "error"
  end

  def update_visitor_app
    if user_is_logged_in?
      unless (profile = Profile.where(user_id: session[:user_id]).first).nil?
        #if (application = VisitorApplication.where(profile_id: profile.id).first).nil?
          application = VisitorApplication.new(app_params)
          application[:profile_id] = profile.id
          application.save!

          p = ProduceList.new(produce_params)
          p[:visitor_application_id] = application.id
          p.save!


        #  render plain: application.inspect
        #  return
        #else
        #  application.update_attributes!(app_params)
        #  application.save!

          render plain: application.inspect
          return
        #end
      end
    end
    render plain: "error"
  end

  def create_man
   
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

  private
    def app_params
      params.permit(:vendor_name, :farm_sales, :value_sales, :ready_sales, :other_sales, :level_of_sales, :primary_loc, :secondary_loc, :acres_owned, :acres_leased, :acres_cultivated, :level_of_acres, :workers_seasonal, :workers_yearly, :level_of_worker_anticipation, :owner1_years, :owner2_years, :owned_by_women, :primary_operators, :primary_operators_other, :certified_organic, :certified_natural, :certified_biodynamic, :certified_food_alliance, :certified_other, :certified_other_name, :certified_none, :num_certified, :under_35, :total_distance, :num_locations, :profile_id, :operators_white, :operators_mexican, :operators_black, :operators_indian, :operators_asian, :unique_crops, :operators_other,:miles_prim,  :miles_second, :source_prim, :dest_prim, :source_second, :dest_second, :hours_brassica, :hours_sprouts, :hours_lettuce, :hours_beans, :hours_carrots, :hours_tomatoes, :hours_corn, :hours_melons, :hours_berries)
    end

  private
    def food_params
      params.permit(:profile_id, :transaction_date, :type_of_assistance, :digits_of_snap, :redeemed, :zip_code, :first_name, :incentive_campaign)
    end

  private
    def credit_params
      params.permit(:profile_id, :transaction_sales, :debit_sales, :credit_sales)
    end
  
  private
    def misc_research_params
      params.permit(:farm_name, :owner_last, :week1, :week2, :week3, :week4, :week5, :week6, :week7, :week8, :week9, :week10, :week11, :week12, :week13, :week14, :week15, :week16, :week17, :week18, :week19, :week20, :week21, :week22, :week23, :week24, :week25, :week26, :week27, :week28, :week29, :week30, :week31, :week32, :week33, :week34, :week35, :week36)
    end

  private
    def program_params
      params.permit(:profile_id, :event_type, :event_date, :youth_specific, :participants, :under_18)
    end  

  private
    def produce_params
      params[:produce_list].permit(:year,:Artichokes,:Arugula ,:Asparagus ,:Beans_green ,:Beans_dry ,:Beets ,:Beet_greens ,:Bok_choy ,:Broccoli,:Broccoli_rabe  ,:Brussels_sprouts  ,:Cabbage_green  ,:Cabbage_purple   ,:Cardoons  ,:Carrots ,:Cauliflower  ,:Celeriac  ,:Celery  ,:Chard  ,:Chicory  ,:Chipilín  ,:Collards  ,:Corn_Sweet  ,:Cress  ,:Cucumbers  ,:Dandelion_greens  ,:Eggplant  ,:Epazote  ,:Fava_beans  ,:Fennel,:Garlic_bulb  ,:Garlic_scapes  ,:Herbs_fresh  ,:Hierbamora ,:Horseradish ,:Jicama,:Kale,:Kohlrabi,:Lambs_quarters,:Leeks,:Lettuce,:Lima_beans  ,:Mesclun_mixed_salad_greens   ,:Mushrooms  ,:Mustard_greens  ,:Okra  ,:Onions  ,:Parsnips  ,:Peas_english  ,:Peas_sugar_snap  ,:Peas_snow  ,:Pea_shoots ,:Peppers_hot  ,:Peppers_sweet_green ,:Peppers_sweet_red   ,:Peppers_sweet_purple  ,:Peppers_sweet_yellow  ,:Potatoes,:Pumpkins  ,:Purslane  ,:Radishes   ,:Rhubarb  ,:Rutabagas ,:Salsify  ,:Scallions  ,:Shallots  ,:Spinach  ,:Sprouts  ,:Squash_aummer  ,:Squash_winter   ,:Sunchokes  ,:Sweet_potatoes  ,:Sweet_potato_greens  ,:Tomatillos,:Tomatoes  ,:Turnips,:Turnip_greens ,:Yacon ,:Apples  ,:Apricots  ,:Apriums  ,:Asian_pears  ,:Blackberries  ,:Blueberries ,:Boysenberries  ,:Canary_melons   ,:Cantaloupes  ,:Cherimoyas  ,:Cherries  ,:Currants  ,:Feijoas  ,:Figs,:Grapefruit  ,:Grapes ,:Honeydew_melons  ,:Mulberries  ,:PawPaws  ,:Peaches  ,:Pears  ,:Plums  ,:Quince,:Raspberries_black  ,:Raspberries_red   ,:Strawberries  ,:Tayberries ,:Watermelon ,:Wineberries ,:Chestnuts ,:Dates,:Jujubes,:Peanuts,:Walnuts_black ,:Walnuts_english)
    end
end
