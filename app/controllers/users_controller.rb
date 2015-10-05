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

  def reset

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

    def visitor_application
      if user_is_logged_in?
          @user = User.find(session[:user_id])
          @profile = Profile.where(user_id: session[:user_id]).first
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

=begin
  	def instruments
    	if user_is_logged_in?
      		@user = User.find(session[:user_id])
      		@profile = profile = Profile.where(user_id: session[:user_id]).first

	    else 
      		redirect_to root_path
    	end
  	end
=end

	def show
		#render plain: user_is_logged_in?
		#return
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

          profiles = Profile.select("name", "id", "day1", "day2", "day3", "day4").where("profiles.id = #{@profile.id}")
          #check
          app_ids = ProduceList.select("visitor_application_id").where("profile_id" => @profile.id).uniq

          @research = MiscResearch.select("profiles.name, misc_researches.*").joins(:profile).order("misc_researches.id").where(:id => @profile.id)
          @events = MarketProgram.select("profiles.name, market_programs.*").joins(:profile).order("market_programs.id").where(:id => @profile.id)
          @volunteers = Volunteer.select("profiles.name, volunteers.*").joins(:profile).order("volunteers.id").where(:id => @profile.id)
        end

          app_ids.each do |k,v|
            unless k.nil? 
            #this is because whoever invented this crappy language never thought to include short curcuit
            #evaluation. Jesus...
              if k.visitor_application_id
                row = Hash.new
                id = k.visitor_application_id

                if (v = VisitorApplication.where(:id => 10).first()).nil?
                  row['application'] = v
                  lists = ProduceList.where("visitor_application_id" => id)
                  row['first'] = lists[0] 
                  row['second'] = lists[1] 
                  @applications << row
                end
              end
            end
          end

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

    		@surveys = VisitorSurvey.where(profile_id: @profile.id)

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
