class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  skip_before_filter :verify_authenticity_token, if: :json_request?

  protected
  def authenticate_user
  	unless session[:user_id]
  		redirect_to(:controller => 'sessions', :action => 'login')
  		return false
  	else
      # set current_user by the current user object
      @current_user = User.find session[:user_id] 
  		return true
  	end
  end

  #This method for prevent user to access Signup & Login Page without logout
  def save_login_state
    if session[:user_id]
      @user = User.find(session[:user_id])
      redirect_to(@user)
            #redirect_to(:controller => 'sessions', :action => 'home')
      return false
    else
      return true
    end
  end

  def user_is_logged_in?
    !!session[:user_id]
  end

  #we use this method to restrict admins from posting data to the site
  def admin?
    return User.find(session[:user_id]).admin
  end
end
