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
        if(@user.admin)
          
          p = Profile.select("profiles.name, visitor_surveys.*").joins(:visitor_survey).order("profiles.id ASC").order("visitor_surveys.date ASC")
          @visitor_surveys << p

          p = Profile.select("profiles.name, sales_slips.*").joins(:sales_slip).order("profiles.id ASC").order("sales_slips.date ASC")
          @sales_slips << p

          points = Profile.select("profiles.name, entry_points.*").joins(:entry_points).order("profiles.id ASC").order("entry_points.int_day ASC").order("entry_points.period ASC")
          @visitor_counts << points

        end

        if(@user.admin)
      		@profiles = {}
      		i = 0
      		profs = Profile.all().order('id')
    	   	profs.each do |p|
    		  	prof = {:profile => p}
      			prof[:markets] = p.markets
      			prof[:management] = p.managements
      			prof[:accessibility] = p.accessibility
    	   		prof[:community] = p.community
    	 	   	@profiles[i] = prof
    			   i += 1
    		  end
        else
          @profiles = {}
        end

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
