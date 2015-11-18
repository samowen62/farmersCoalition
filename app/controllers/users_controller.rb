class UsersController < ApplicationController

	before_filter :save_login_state, :only => [:new, :create]
#User.select(:email).each do |i| puts "#{i.id} #{i.email}" end

	def new
		@user = User.new
	end

	def home
		if user_is_logged_in?
      		@user = User.find(session[:user_id])
	    else 
      		redirect_to root_path
    	end
	end

  def pass_page
    
  end 

  #change user's password
  def change_pass
    u = User.where(:reset_hash => params[:hash])
    if u.count() == 0
      render plain: "ded"
      return
    else
      u = u.first()
      if (params[:pass_confirm] == params[:pass]) and !params[:pass_confirm].nil? and params[:pass_confirm].length > 0 
        u.salt = BCrypt::Engine.generate_salt
        u.pass = BCrypt::Engine.hash_secret(params[:pass], u.salt)
        u.save!
      end
      render plain: "ded "
      return  
    end 
  end

  def reset
    u = User.where(:reset_hash => params[:hash])
    if u.count() == 0
      redirect_to root_path
    end 
    @user = u.first()
  end

  def pass_reset
      UserMailer.password_email(params[:email])
      render plain: "death"
      return
  end

	def metrics
    	if user_is_logged_in?
      		@user = User.find(session[:user_id])
      		@profile = Profile.where(user_id: session[:user_id]).first
      		@metrics = metric_calc(@profile)
	    else 
      		redirect_to root_path
    	end
  	end

    def metric3
      if user_is_logged_in?
          @user = User.find(session[:user_id])
          @profile = Profile.where(user_id: session[:user_id]).first
          @metrics = metric_calc(@profile)
      else 
          redirect_to root_path
      end
    end

    def edit_application
      if user_is_logged_in?
          @user = User.find(session[:user_id])
          @profile = Profile.where(user_id: session[:user_id]).first
          @past_apps = Profile.find(@profile.id).visitor_application.select(:id,:vendor_name)
          @metrics = metric_calc(@profile)
          #@application = @profile.visitor_application
          #@application = []
          @application = VisitorApplication.where(:profile_id => @profile.id).where(:id => params[:id]).first()
          @list2014 = {}
          @list2015 = {}
          unless @application.nil?
            @list2014 = ProduceList.where(:visitor_application_id => @application.id).where(:year => 2014).first()
            @list2015 = ProduceList.where(:visitor_application_id => @application.id).where(:year => 2015).first()
          else
            @application = {}
          end

          render  "visitor_application"
          return
      else 
          redirect_to root_path
      end
    end

    def visitor_application
      if user_is_logged_in?
          @user = User.find(session[:user_id])
          @profile = Profile.where(user_id: session[:user_id]).first
          @past_apps = Profile.find(@profile.id).visitor_application.select(:id,:vendor_name)
          @metrics = metric_calc(@profile)
          #@application = @profile.visitor_application
          #@application = []
      else 
          redirect_to root_path
      end
    end

    def food_assistance
      if user_is_logged_in?
          @user = User.find(session[:user_id])
          @profile = Profile.where(user_id: session[:user_id]).first
          @accessibility = @profile.accessibility
          @metrics = metric_calc(@profile)
          @foods = FoodAssistance.where(profile_id: @profile.id).order(:transaction_date)
      else 
          redirect_to root_path
      end
    end

    def credit_sales
      if user_is_logged_in?
          @user = User.find(session[:user_id])
          @profile = Profile.where(user_id: session[:user_id]).first
          @metrics = metric_calc(@profile)
          @sales = CreditSales.where(profile_id: @profile.id)
      else 
          redirect_to root_path
      end
    end

    def misc_research
      if user_is_logged_in?
          @user = User.find(session[:user_id])
          @profile = Profile.where(user_id: session[:user_id]).first
          @metrics = metric_calc(@profile)
          @research = MiscResearch.where(profile_id: @profile.id).order(:id)
      else 
          redirect_to root_path
      end
    end

    def programs
      if user_is_logged_in?
          @user = User.find(session[:user_id])
          @profile = Profile.where(user_id: session[:user_id]).first
          @metrics = metric_calc(@profile)
          @program = MarketProgram.where(profile_id: @profile.id).order(:id)
      else 
          redirect_to root_path
      end
    end


	def show
		if user_is_logged_in?
  		@user = User.find(session[:user_id])
  		@profile = Profile.where(user_id: session[:user_id]).first
  		unless @profile.nil?
    		@markets = @profile.markets
  			@management = @profile.managements
  			@accessibility = @profile.accessibility
        if @accessibility == {}
          @accessibility = {
            'accept_SNAP' => false,
            'accept_FMNP' => false,
            'FMNP_available' => false,
            'accept_FMNP_senior' => false,
            'FMNP_senior_available' => false,
            'accept_CVV' => false,
            'CVV_available' => false,
            'other_vouchers' => false
          }
        end
  			@positions = Array.new
  			@communities = @profile.community

  			unless  @management.nil?
    			for i in 0..11
    				@positions.push(@management.pos(i))
    			end
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
    		@management = @profile.managements
    		@accessibility = @profile.accessibility
    		@communities = @profile.community

        @visitor_surveys = []
        @sales_slips = []
        @visitor_counts = []
        @applications = []
        @assistances = []
        @credit = []
        @research = []
        @events = []
        @volunteers = []
        app_ids = []

    		@surveys = VisitorSurvey.where(profile_id: @profile.id)

    	else 
    		redirect_to root_path
    	end
  	end

    def csv_metric_request
      if user_is_logged_in?
        @user = User.find(session[:user_id])
        session[:user_id] = @user.id

        @profile = Profile.where(user_id: session[:user_id]).first

        case params[:type].to_i
        when 1 #profile
          @profiles = {}
          i = 0

          profs = if @user.admin then Profile.all().order('id') else [Profile.find(@profile.id)] end

          profs.each do |p|
            prof = {:profile => p}
            prof[:markets] = p.markets
            prof[:management] = p.managements
            prof[:accessibility] = p.accessibility
            prof[:community] = p.community
            @profiles[i] = prof
             i += 1
          end
          ret = @profiles

        when 2 #survey
          slips = if @user.admin then
            Profile.select("profiles.name, visitor_surveys.*").joins(:visitor_survey).order("profiles.id ASC").order("visitor_surveys.date ASC")
          else
            Profile.select("profiles.name, visitor_surveys.*").joins(:visitor_survey).where("profiles.id = #{@profile.id}").order("visitor_surveys.date ASC")
          end

          sql = if @user.admin then
            "select count(home_zip), home_zip, profiles.name, date from visitor_surveys left join profiles on profiles.id = visitor_surveys.profile_id group by date, home_zip, profiles.name order by profiles.name;"
          else
            "select count(home_zip), home_zip, profiles.name, date from visitor_surveys left join profiles on profiles.id = visitor_surveys.profile_id where profiles.id = #{@profile.id} group by date, home_zip, profiles.name;"
          end
          zips = ActiveRecord::Base.connection.execute(sql)

          ret = Hash.new
          ret['slips'] = slips
          ret['zips'] = zips

        when 3 #Counts
          profiles = if @user.admin then
            Profile.select("name", "id", "day1", "day2", "day3", "day4")
          else
            Profile.select("name", "id", "day1", "day2", "day3", "day4").where("profiles.id = #{@profile.id}")
          end

          visitor_counts = []
          for prof in profiles do
            points = prof.entry_points.order(ptNum: :asc)
            if points.count() == 0
              next
            end
            profile = Hash.new

            prof_points = []
            day = []
            for i in 0..3 do
              for j in 0..8 do
                day.push([])
              end
              prof_points.push(day)
              day = []
            end

            for p in points do
              prof_points[p.int_day][p.period].push(p)
            end 
            profile["points"] = prof_points
            profile["name"] = prof.name
            profile["day0"] = prof.day1
            profile["day1"] = prof.day2
            profile["day2"] = prof.day3
            profile["day3"] = prof.day4

            visitor_counts.push(profile)
          end
          ret = visitor_counts

        when 4 #sales slips
          sales_p = if @user.admin then
            sales_p =Profile.select('profiles.*').joins(:sales_slip).uniq
          else
            sales_p =Profile.select('profiles.*').where("profiles.id = #{@profile.id}").joins(:sales_slip).uniq
          end
          slips = []

          for sp in sales_p do
            dates = sp.sales_slip.select(:date).order(:date).uniq
            prof = Hash.new
            s = []
            for d in dates
              s.push(SalesSlip.select("*").where(profile_id: sp.id, date: d.date))
            end
            prof[:slips] = s
            prof[:name] = sp.name

            slips.push(prof)
          end
          ret = slips

        when 5 #assistance
          ret = Hash.new
          ret['assistances'] = if @user.admin then 
            FoodAssistance.select("food_assistance.*, profiles.name").joins(:profile).order("profile_id ASC").order("food_assistance.id ASC")
          else 
            FoodAssistance.select("food_assistance.*, profiles.name").where("profiles.id = #{@profile.id}").joins(:profile).order("profile_id ASC").order("food_assistance.id ASC")
          end

          snap_sql = if @user.admin then
            "select transaction_date, profiles.name, count(*), array_length(array_agg(distinct digits_of_snap),1) from food_assistance left join profiles on profiles.id = profile_id group by profiles.name, transaction_date order by profiles.name, transaction_date;"
          else
           "select transaction_date, profiles.name, count(*), array_length(array_agg(distinct digits_of_snap),1) from food_assistance left join profiles on profiles.id = profile_id where profiles.id = #{@profile.id} group by profiles.name, transaction_date order by profiles.name, transaction_date ;"
          end
          ret['assistance_snap'] = ActiveRecord::Base.connection.execute(snap_sql)

        when 6 #credit_debit
          ret = if @user.admin then
            CreditSales.select("credit_sales.*, profiles.name").joins(:profile).order("profile_id ASC").order("credit_sales.id ASC")
          else
            CreditSales.select("credit_sales.*, profiles.name").where("profiles.id = #{@profile.id}").joins(:profile).order("profile_id ASC").order("credit_sales.id ASC")
          end

        when 7 #vendor app
          app_ids = if @user.admin then
            ProduceList.select("visitor_application_id").uniq
          else
            ProduceList.select("visitor_application_id").joins(:visitor_application).where("visitor_applications.profile_id" => @profile.id).uniq
          end

          ret = []
          app_ids.each do |k,v|
            unless k.nil? 
            #this is because whoever invented this crappy language never thought to include short curcuit
            #evaluation. Jesus...
              if k.visitor_application_id
                row = Hash.new
                id = k.visitor_application_id

                unless (v = VisitorApplication.where(:id => id).joins(:profile).select("visitor_applications.*, profiles.name").first()).nil?
                  row['application'] = v
                  lists = ProduceList.where("visitor_application_id" => id)
                  row['first'] = lists[0] 
                  row['second'] = lists[1] 
                  ret << row
                end
              end
            end
          end
          ret.sort! { |x, y| x['application'].name <=> y['application'].name }

        when 8 #attendance
          ret = if @user.admin then
            MiscResearch.select("profiles.name, misc_researches.*").joins(:profile).order("profile_id, misc_researches.id")
          else
            MiscResearch.select("profiles.name, misc_researches.*").joins(:profile).order("profile_id, misc_researches.id").where(:id => @profile.id)
          end

        when 9 #events
          ret = if @user.admin then 
            MarketProgram.select("market_programs.*, profiles.name").joins(:profile).order("profile_id ASC").order("market_programs.id ASC")
          else
            MarketProgram.select("market_programs.*, profiles.name").joins(:profile).order("profile_id ASC").order("market_programs.id ASC").where(:id => @profile.id)
          end

        when 10 #volunteers
          vols = if @user.admin then
            Volunteer.select("volunteers.*, profiles.name, profiles.address").joins(:profile).order("profile_id ASC").order("volunteers.id ASC")
          else
            Volunteer.select("volunteers.*, profiles.name, profiles.address").joins(:profile).order("profile_id ASC").order("volunteers.id ASC").where(:id => @profile.id)
          end

          for v in vols do 
            #address is used so we can replace it
            num = (v.departure.length > 0 ? Time.parse(v.departure).to_i : 0) - (v.arrival.length > 0 ? Time.parse(v.arrival).to_i : 0)
            v.address = ((num * 1.0)/3600.0)
          end
          ret = vols

        when 11 
          profiles = if @user.admin then 
            Profile.all
          else
            [@profile]
          end

          ret = []
          profiles.each do |p|
            metrics = metric_calc(p)
            ret << {data: calc_metrics(metrics,p), name: p.name}
          end
        else
          ret = []
        end

        render plain: ret.to_json
        return

      else 
        redirect_to root_path
      end
    end

    def calc_metrics(mets, profile)
      metrics = Hash.new

        if mets[0]
          metrics["1"] = []
          metrics["1"].push({count: EntryPoint.where(:profile_id => profile.id).where(:int_day => 0).sum(:count), day: profile.day1})
          metrics["1"].push({count: EntryPoint.where(:profile_id => profile.id).where(:int_day => 1).sum(:count), day: profile.day2})
          metrics["1"].push({count: EntryPoint.where(:profile_id => profile.id).where(:int_day => 2).sum(:count), day: profile.day3})
          metrics["1"].push({count: EntryPoint.where(:profile_id => profile.id).where(:int_day => 3).sum(:count), day: profile.day4})
        end
        if mets[1]
          metrics["2"] = Hash.new
          #not sure which to use
          metrics["2"]["sales_slip"] = profile.sales_slip.select("sum(total_sales) as total, sum(farm_sales) as farm, sum(value_sales) as value, sum(ready_sales) as ready")
          metrics["2"]["application"] = profile.visitor_application.select("sum(total_gross) as total, sum(farm_sales) as farm, sum(value_sales) as value, sum(ready_sales) as ready")
        end
        if mets[2]
          metrics["3"] = Hash.new
          metrics["3"]["primary"] = profile.visitor_application.sum(:miles_prim)
          metrics["3"]["secondary"] = profile.visitor_application.sum(:miles_second)
          #need year specification
        end
        if mets[3]
          metrics["4"] = profile.visitor_application.select("acres_owned, acres_leased, acres_cultivated")
        end
        if mets[4]
          metrics["5"] = ActiveRecord::Base.connection.execute("select distinct farm_name from misc_researches where profile_id = #{profile.id} and (coalesce(week1,0)+coalesce(week2,0)+coalesce(week3,0)+coalesce(week4,0)+coalesce(week5,0)+coalesce(week6,0)+coalesce(week7,0)+coalesce(week8,0)+coalesce(week9,0)+coalesce(week10,0)+coalesce(week11,0)+coalesce(week12,0)+coalesce(week13,0)+coalesce(week14,0)+coalesce(week15,0)+coalesce(week16,0)+coalesce(week17,0)+coalesce(week18,0)+coalesce(week19,0)+coalesce(week20,0)+coalesce(week21,0)+coalesce(week22,0)+coalesce(week23,0)+coalesce(week24,0)+coalesce(week25,0)+coalesce(week26,0)+coalesce(week27,0)+coalesce(week28,0)+coalesce(week29,0)+coalesce(week30,0)+coalesce(week31,0)+coalesce(week32,0)+coalesce(week33,0)+coalesce(week34,0)+coalesce(week35,0)+coalesce(week36,0)) > 0;")
        end
        if mets[5]
          #no info
        end
        if mets[6]
          metrics["7"] = profile.visitor_survey.average(:downtown_spent_morning)
          #metrics["7"] = ActiveRecord::Base.connection.execute("select avg(downtown_spent_morning) as avg from visitor_surveys group by profile_id")
        end
        if mets[7]
          metrics["8"] = Hash.new
          #not sure which to use
          metrics["8"]["slip"] = profile.sales_slip.average(:Debt_sales)#.groupBy(:profile_id)
          metrics["8"]["credit"] = CreditSales.select("avg(credit_sales) as credit, avg(debit_sales) as debit").where(:profile_id => profile.id)
        end
        if mets[8]
          metrics["9"] = {seasonal: profile.visitor_application.sum(:workers_seasonal), yearly: profile.visitor_application.sum(:workers_yearly)}
        end
        if mets[9]
          metrics["10"] = Hash.new
          #not sure which to use
          metrics["10"]["sales_slip"] = profile.sales_slip.select("sum(farm_sales) as farm, sum(value_sales) as value, sum(ready_sales) as ready")
          metrics["10"]["application"] = profile.visitor_application.select("sum(farm_sales) as farm, sum(value_sales) as value, sum(ready_sales) as ready")
        end
        if mets[10]
          metrics["11"] = profile.visitor_survey.average(:spent_morning)
        end
        if mets[11]
          #ask about this
          metrics["12"] = Hash.new
          total1 = profile.visitor_application.where("owner1_years is not NULL").count()
          sum1 = profile.visitor_application.select("sum(owner1_years)").where("owner1_years >= 10")
          total2 = profile.visitor_application.where("owner2_years is not NULL").count()
          sum2 = profile.visitor_application.select("sum(owner2_years)").where("owner2_years >= 10")
          metrics["12"]["1"] = if total1 > 0 then sum1 / total1 else 0 end 
          metrics["12"]["2"] = if total2 > 0 then sum2 / total2 else 0 end 
        end
        if mets[12]
          #needs modification
          metrics["13"] = profile.visitor_survey.select("sum(yes13) as sum, count(*) as total, date").group(:date)

        end
        if mets[13]
          slips = Hash.new
          #this one is confusing to know which one too
          #\"SNAP_sales\"/NULLIF(\"SNAP_transactions\",0) as avg
          slips["april"] = profile.sales_slip.select("sum(\"SNAP_transactions\")").where("EXTRACT(MONTH FROM date) = 4")
          slips["may"] = profile.sales_slip.select("sum(\"SNAP_transactions\")").where("EXTRACT(MONTH FROM date) = 5")
          slips["june"] = profile.sales_slip.select("sum(\"SNAP_transactions\")").where("EXTRACT(MONTH FROM date) = 6")
          slips["july"] = profile.sales_slip.select("sum(\"SNAP_transactions\")").where("EXTRACT(MONTH FROM date) = 7")
          slips["august"] = profile.sales_slip.select("sum(\"SNAP_transactions\")").where("EXTRACT(MONTH FROM date) = 8")
          slips["september"] = profile.sales_slip.select("sum(\"SNAP_transactions\")").where("EXTRACT(MONTH FROM date) = 9")
          
          #just the number
          assistance = Hash.new
          assistance["april"] = profile.food_assistance.where(:type_of_assistance => "SNAP").where("EXTRACT(MONTH FROM transaction_date) = 4").count()
          assistance["may"] = profile.food_assistance.where(:type_of_assistance => "SNAP").where("EXTRACT(MONTH FROM transaction_date) = 5").count()
          assistance["june"] = profile.food_assistance.where(:type_of_assistance => "SNAP").where("EXTRACT(MONTH FROM transaction_date) = 6").count()
          assistance["july"] = profile.food_assistance.where(:type_of_assistance => "SNAP").where("EXTRACT(MONTH FROM transaction_date) = 7").count()
          assistance["august"] = profile.food_assistance.where(:type_of_assistance => "SNAP").where("EXTRACT(MONTH FROM transaction_date) = 8").count()
          assistance["september"] = profile.food_assistance.where(:type_of_assistance => "SNAP").where("EXTRACT(MONTH FROM transaction_date) = 9").count()

          metrics["14"] = Hash.new
          metrics["14"]['slips'] = slips
          metrics["14"]['assistance'] = assistance
        end
        if mets[14]

          #check these again
          metrics["15"] = Hash.new
          metrics["15"]['slips'] = profile.sales_slip.select("sum(\"SNAP_transactions\")").where("\"SNAP_transactions\" is not null")
          metrics["15"]['assistance'] = profile.food_assistance.select("sum(redeemed)").where(:type_of_assistance => "SNAP").where("redeemed is not null")
        end
        if mets[15]

          metrics["16"] = Hash.new
          metrics["16"]['slips'] = profile.sales_slip.select("sum(\"WIC_FMNP_sales\")").where("\"WIC_FMNP_sales\" is not null")
          metrics["16"]['assistance'] = profile.food_assistance.select("sum(redeemed)").where(:type_of_assistance => "WIC FMNP").where("redeemed is not null")
        end
        if mets[16]

          metrics["17"] = Hash.new
          metrics["17"]['slips'] = profile.sales_slip.select("sum(\"WIC_sales\")").where("\"WIC_sales\" is not null")
          metrics["17"]['assistance'] = profile.food_assistance.select("sum(redeemed)").where(:type_of_assistance => "WIC CVV").where("redeemed is not null")
        end
        if mets[17]

          metrics["18"] = Hash.new
          metrics["18"]["april"] = profile.food_assistance.where("EXTRACT(MONTH FROM transaction_date) = 4").select(:digits_of_snap).uniq
          metrics["18"]["may"] = profile.food_assistance.where("EXTRACT(MONTH FROM transaction_date) = 5").select(:digits_of_snap).uniq
          metrics["18"]["june"] = profile.food_assistance.where("EXTRACT(MONTH FROM transaction_date) = 6").select(:digits_of_snap).uniq
          metrics["18"]["july"] = profile.food_assistance.where("EXTRACT(MONTH FROM transaction_date) = 7").select(:digits_of_snap).uniq
          metrics["18"]["august"] = profile.food_assistance.where("EXTRACT(MONTH FROM transaction_date) = 8").select(:digits_of_snap).uniq
          metrics["18"]["september"] = profile.food_assistance.where("EXTRACT(MONTH FROM transaction_date) = 9").select(:digits_of_snap).uniq
        end
        if mets[18]
          #check this one too by putting a bunch of sample values into assistance
          #metrics["19"] profile.food_assistance.where("count(select distinct transaction_date")
        end
        if mets[20]

          metrics["21"] = Hash.new
          metrics["21"]['slips'] = profile.sales_slip.select("sum(\"Senior_FMNP_sales\")").where("\"Senior_FMNP_sales\" is not null")
          metrics["21"]['assistance'] = profile.food_assistance.select("sum(redeemed)").where(:type_of_assistance => "Senior FMNP").where("redeemed is not null")
        end
        if mets[21]
          num = profile.visitor_application.where(:owned_by_women => "yes").count()
          den = profile.visitor_application.count()
          metrics["22"] = den > 0 ? num / den : 0;
        end
        if mets[22]
          #no idea how to do this one
          metrics["23"]
        end
        #24
        if mets[24]
          # or certified_natural or certified_biodynamic or certified_food_alliance or certified_other         
          metrics["25"] = profile.visitor_application.where("certified_organic = TRUE").count()
        end
        if mets[25]
          metrics["26"] = profile.visitor_application.select("sum(num_certified)")
        end
        if mets[26]
          apps = profile.visitor_application
          keys = {}
          for p in apps do 
            produce = p.produce_list
            if produce.size > 0
              produce[0].attributes.each do |k, v|
                if v && !keys.key?(k)
                  keys[k] = 1;
                end
              end
            end
            if produce.size == 2
              produce[1].attributes.each do |k, v|
                if v && !keys.key?(k)
                  keys[k] = 1;
                end
              end
            end
          end

          metrics["27"] = keys.size - 2 #id and year
        end
        if mets[27]
          n = profile.visitor_survey.where(:yes28 => 0).count()
          den = profile.visitor_survey.where(:yes28 => 1).count() + n
          metrics["28"] = if den > 0 then n / den else 0 end
        end
        if mets[28]
          metrics["29"] = profile.visitor_application.select("sum(under_35)")
        end
        if mets[29]
          vols = profile.volunteer.select("volunteers.*")
          sum = 0
          sum_comm = 0

          for v in vols do 
            num = (v.departure.length > 0 ? Time.parse(v.departure).to_i : 0) - (v.arrival.length > 0 ? Time.parse(v.arrival).to_i : 0)
            sum += ((num * 1.0)/3600.0)
            sum_comm += v.hours_committed ? v.hours_committed : 0
          end
          metrics["30"] = {sum: sum, committed: sum_comm}
        end
        if mets[30]
          sql = "select count(home_zip), home_zip, profiles.name, date from visitor_surveys left join profiles on profiles.id = visitor_surveys.profile_id where profiles.id = #{profile.id} group by date, home_zip, profiles.name;"
          metrics["31"] = ActiveRecord::Base.connection.execute(sql) 
        end
        if mets[31]
          #don't know how v app tied in
          lbs = profile.sales_slip.select("sum(pounds_donated)")
          val = profile.sales_slip.select("sum(values_donated)")
          metrics["32"] = {pounds: lbs, value: val}
        end
        if mets[32]
          metrics["33"] = profile.market_program.where("event_type = 'Demonstrations' or event_type = 'Skills workshops'").count()
        end
        #no 34 /35
        if mets[35]
          v1 = profile.sales_slip.select("veg1, count(veg1)").group(:veg1).uniq
          v2 = profile.sales_slip.select("veg2, count(veg2)").group(:veg2).uniq
          v3 = profile.sales_slip.select("veg3, count(veg3)").group(:veg3).uniq
          vegs = {}

          for i in v1 do 
            unless i.veg1.nil?
              vegs[i.veg1] = i.count + (vegs.key?(i.veg1) ? vegs[i.veg1] : 0)
            end
          end
          for i in v2 do 
            unless i.veg2.nil?
              vegs[i.veg2] = i.count + (vegs.key?(i.veg2) ? vegs[i.veg2] : 0)
            end
          end
          for i in v3 do 
            unless i.veg3.nil?
              vegs[i.veg3] = i.count + (vegs.key?(i.veg3) ? vegs[i.veg3] : 0)
            end
          end

          metrics["36"] = vegs
        end
        if mets[36]
          metrics["37"] = profile.market_program.select("sum(under_18)")
        end

        return metrics
    end

    def metric_data
      if user_is_logged_in?
        @user = User.find(session[:user_id])
        session[:user_id] = @user.id
        @profile = Profile.where(user_id: session[:user_id]).first
        @metrics = metric_calc(@profile)

        #profiles = Profile.all
        @data = {data: calc_metrics(@metrics, @profile), name: @profile.name}

      else
        redirect_to root_path
      end
    end


  	def visitor_survey
  		if user_is_logged_in?
  			@user = User.find(session[:user_id])
    		session[:user_id] = @user.id
    		@profile = Profile.where(user_id: session[:user_id]).first
    		@metrics = metric_calc(@profile)
  		else
  			redirect_to root_path
  		end
  	end

    def volunteers
      if user_is_logged_in?
        @user = User.find(session[:user_id])
        session[:user_id] = @user.id
        @profile = Profile.where(user_id: session[:user_id]).first
        @vols = Volunteer.where(profile_id: @profile.id).order(:id)
      else
        redirect_to root_path
      end
    end

	def visitor_count
  		if user_is_logged_in?
  			@user = User.find(session[:user_id])
    		session[:user_id] = @user.id
    		@profile = Profile.where(user_id: session[:user_id]).first
        points = @profile.entry_points.order(ptNum: :asc)

        @points = []
        day = []
        for i in 0..3 do
          for j in 0..8 do
            day.push([])
          end
          @points.push(day)
          day = []
        end

        for p in points do
          @points[p.int_day][p.period].push(p)
        end 
  		else
  			redirect_to root_path
  		end
  	end

 	def sales_slip
  		if user_is_logged_in?
  			@user = User.find(session[:user_id])
    		session[:user_id] = @user.id
    		@profile = Profile.where(user_id: session[:user_id]).first
    		@metrics = metric_calc(@profile)
    		@slip = SalesSlip.where(date: Date.today).where(profile_id: @profile.id).first
  		else
  			redirect_to root_path
  		end
  	end

	def create
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


	private
	  def user_params
	    params.require(:user).permit(:email, :password , :password_confirmation)
	  end


	def metric_calc(profile)
		metrics = Array.new

		if profile[:metrics_1].nil?
			profile[:metrics_1] = 0
		end
		if profile[:metrics_2] .nil?
			profile[:metrics_2] = 0
		end

		for i in 0..19
			metrics[i] = ((profile[:metrics_1] >> i) % 2 == 1)
		end
		for i in 20..39
			metrics[i] = ((profile[:metrics_2] >> i - 20) % 2 == 1)
		end
		return metrics
	end

end
