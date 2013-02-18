class ApplicationController < ActionController::Base
  protect_from_forgery
  
  def current_user
if session[:user_id]
# ||= assigns only if not already assigned (only calling db if necessary)
@current_user ||= User.find(session[:user_id])
end
@current_user
	end
	
	def logged_in?
		!!current_user
	end
	
	def require_user
		redirect_to log_in_path unless logged_in?
	end
	
	helper_method :current_user, :logged_in?, :require_user
end
