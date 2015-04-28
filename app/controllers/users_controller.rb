class UsersController < ApplicationController

	before_filter :save_login_state, :only => [:new, :create]

	def new
		@user = User.new
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

  	def instruments
    	if user_is_logged_in?
      		@user = User.find(session[:user_id])
      		@profile = profile = Profile.where(user_id: session[:user_id]).first

	    else 
      		redirect_to root_path
    	end
  	end

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
