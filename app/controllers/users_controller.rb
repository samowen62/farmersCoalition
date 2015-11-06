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
=begin
        if(@user.admin)
          
          p = Profile.select("profiles.name, visitor_surveys.*").joins(:visitor_survey).order("profiles.id ASC").order("visitor_surveys.date ASC")
          @visitor_surveys << p
          sales_p = Profile.select('profiles.*').joins(:sales_slip).uniq
          slips = []
          profiles = Profile.select("name", "id", "day1", "day2", "day3", "day4")
          app_ids = ProduceList.select("visitor_application_id").uniq
          

          @assistances = FoodAssistance.select("food_assistance.*, profiles.name").joins(:profile).order("profile_id ASC").order("food_assistance.id ASC")

          snap_sql = "select transaction_date, profiles.name, count(*), array_length(array_agg(distinct digits_of_snap),1) from food_assistance left join profiles on profiles.id = profile_id group by profiles.name, transaction_date order by profiles.name, transaction_date;"
          @assistance_snap = ActiveRecord::Base.connection.execute(snap_sql)

          @research = MiscResearch.select("profiles.name, misc_researches.*").joins(:profile).order("profile_id, misc_researches.id")
          @credit = CreditSales.select("credit_sales.*, profiles.name").joins(:profile).order("profile_id ASC").order("credit_sales.id ASC")
          @events = MarketProgram.select("market_programs.*, profiles.name").joins(:profile).order("profile_id ASC").order("market_programs.id ASC")
          @volunteers = Volunteer.select("volunteers.*, profiles.name, profiles.address").joins(:profile).order("profile_id ASC").order("volunteers.id ASC")
        else
          p = Profile.select("profiles.name, visitor_surveys.*").joins(:visitor_survey).where("profiles.id = #{@profile.id}").order("visitor_surveys.date ASC")
          @visitor_surveys << p

          sales_p = Profile.select('profiles.*').where("profiles.id = #{@profile.id}").joins(:sales_slip).uniq
          slips = []
          snap_sql = "select transaction_date, profiles.name, count(*), array_length(array_agg(distinct digits_of_snap),1) from food_assistance left join profiles on profiles.id = profile_id where profiles.id = #{@profile.id} group by profiles.name, transaction_date order by profiles.name, transaction_date ;"
          @assistance_snap = ActiveRecord::Base.connection.execute(snap_sql)

          profiles = Profile.select("name", "id", "day1", "day2", "day3", "day4").where("profiles.id = #{@profile.id}")
          app_ids = ProduceList.select("visitor_application_id").joins(:visitor_application).where("visitor_applications.profile_id" => @profile.id).uniq
          #app_ids = ProduceList.select("visitor_application_id").where("profile_id" => @profile.id).uniq

          @research = MiscResearch.select("profiles.name, misc_researches.*").joins(:profile).order("misc_researches.id").where(:id => @profile.id)
          @events = MarketProgram.select("profiles.name, market_programs.*").joins(:profile).order("market_programs.id").where(:id => @profile.id)
          @volunteers = Volunteer.select("profiles.name, volunteers.*, profiles.address").joins(:profile).order("volunteers.id").where(:id => @profile.id)
        end

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
                  @applications << row
                end
              end
            end
          end
          @applications.sort! { |x, y| x['application'].name <=> y['application'].name }

          for v in @volunteers do 
            #address is used so we can replace it
            num = (v.departure.length > 0 ? Time.parse(v.departure).to_i : 0) - (v.arrival.length > 0 ? Time.parse(v.arrival).to_i : 0)
            v.address = ((num * 1.0)/3600.0)
          end
          
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

          @sales_slips = slips

          

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

            @visitor_counts.push(profile)
          end

      		@profiles = {}
      		i = 0

          if @user.admin
        		profs = Profile.all().order('id')
          else
            profs = [Profile.find(@profile.id)]
          end

    	   	profs.each do |p|
    		  	prof = {:profile => p}
      			prof[:markets] = p.markets
      			prof[:management] = p.managements
      			prof[:accessibility] = p.accessibility
    	   		prof[:community] = p.community
    	 	   	@profiles[i] = prof
    			   i += 1
    		  end
        #else
        #  @profiles = {}
        #end
=end
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
            "select count(home_zip), home_zip, profiles.name, date from visitor_surveys profiles.id = #{@profile.id} left join profiles on profiles.id = visitor_surveys.profile_id group by date, home_zip, profiles.name;"
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
        when 11 #test

        else
          ret = []
        end

        render plain: ret.to_json
        return

      else 
        redirect_to root_path
      end
    end

    def metric_data
      if user_is_logged_in?
        @user = User.find(session[:user_id])
        session[:user_id] = @user.id
        @profile = Profile.where(user_id: session[:user_id]).first
        @metrics = metric_calc(@profile)

        metrics = Hash.new

        if @metrics[0]
          metrics["1"] = []
          metrics["1"].push({count: EntryPoint.where(:profile_id => @profile.id).where(:int_day => 0).sum(:count), day: @profile.day1})
          metrics["1"].push({count: EntryPoint.where(:profile_id => @profile.id).where(:int_day => 1).sum(:count), day: @profile.day2})
          metrics["1"].push({count: EntryPoint.where(:profile_id => @profile.id).where(:int_day => 2).sum(:count), day: @profile.day3})
          metrics["1"].push({count: EntryPoint.where(:profile_id => @profile.id).where(:int_day => 3).sum(:count), day: @profile.day4})
        end
        if @metrics[1]
          metrics["2"] = Hash.new
          metrics["2"]["sales_slip"] = @profile.sales_slip.select("sum(total_sales) as total, sum(farm_sales) as farm, sum(value_sales) as value, sum(ready_sales) as ready")
          metrics["2"]["application"] = @profile.visitor_application.select("sum(total_gross) as total, sum(farm_sales) as farm, sum(value_sales) as value, sum(ready_sales) as ready")
        end
        if @metrics[2]
          metrics["3"] = Hash.new
          metrics["3"]["primary"] = @profile.visitor_application.sum(:miles_prim)
          metrics["3"]["secondary"] = @profile.visitor_application.sum(:miles_second)
          #need year specification
        end
        if @metrics[3]
          metrics["4"] = @profile.visitor_application.select("acres_owned, acres_leased, acres_cultivated")
        end
        if @metrics[4]
          metrics["5"] = ActiveRecord::Base.connection.execute("select distinct farm_name from misc_researches where profile_id = #{@profile.id} and (coalesce(week1,0)+coalesce(week2,0)+coalesce(week3,0)+coalesce(week4,0)+coalesce(week5,0)+coalesce(week6,0)+coalesce(week7,0)+coalesce(week8,0)+coalesce(week9,0)+coalesce(week10,0)+coalesce(week11,0)+coalesce(week12,0)+coalesce(week13,0)+coalesce(week14,0)+coalesce(week15,0)+coalesce(week16,0)+coalesce(week17,0)+coalesce(week18,0)+coalesce(week19,0)+coalesce(week20,0)+coalesce(week21,0)+coalesce(week22,0)+coalesce(week23,0)+coalesce(week24,0)+coalesce(week25,0)+coalesce(week26,0)+coalesce(week27,0)+coalesce(week28,0)+coalesce(week29,0)+coalesce(week30,0)+coalesce(week31,0)+coalesce(week32,0)+coalesce(week33,0)+coalesce(week34,0)+coalesce(week35,0)+coalesce(week36,0)) > 0;")
        end
        if @metrics[5]
          #no info
        end
        if @metrics[6]
          metrics["7"] = @profile.visitor_survey.average(:downtown_spent_morning)
          #metrics["7"] = ActiveRecord::Base.connection.execute("select avg(downtown_spent_morning) as avg from visitor_surveys group by profile_id")
        end
        if @metrics[7]
          metrics["8"] = Hash.new
          metrics["8"]["slip"] = @profile.sales_slip.average(:Debt_sales)#.groupBy(:profile_id)
          metrics["8"]["credit"] = CreditSales.select("avg(credit_sales) as credit, avg(debit_sales) as debit").where(:profile_id => @profile.id)
        end
        if @metrics[8]
          metrics["9"] = {seasonal: @profile.visitor_application.sum(:workers_seasonal), yearly: @profile.visitor_application.sum(:workers_yearly)}
        end
        if @metrics[9]
          metrics["10"] = Hash.new
          metrics["10"]["sales_slip"] = @profile.sales_slip.select("sum(farm_sales) as farm, sum(value_sales) as value, sum(ready_sales) as ready")
          metrics["10"]["application"] = @profile.visitor_application.select("sum(farm_sales) as farm, sum(value_sales) as value, sum(ready_sales) as ready")
        end
        if @metrics[10]
          metrics["11"] = @profile.visitor_survey.average(:spent_morning)
        end
        if @metrics[11]
          metrics["12"] = @profile.visitor_survey.average(:spent_morning)
        end
        if @metrics[12]
          #needs modification
          metrics["13"] = @profile.visitor_survey.select("sum(yes13) as sum, count(*) as total, date").group(:date)

        end





        render plain: metrics.to_json
        return
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
