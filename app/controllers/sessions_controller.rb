class SessionsController < ApplicationController

	def index
    if logged_in?
      redirect_to :controller=>'shouts', :action => 'index'
    else
      redirect_to :controller=>'sessions', :action => 'new'
    end
  end

  def new
    if logged_in?
    redirect_to :controller=>'shouts', :action => 'index'
    end
  end

  def create
	if user = User.find_by_email(params[:email]).try(:authenticate, params[:password])
	session[:user_id] = user.id
	redirect_to shouts_path
	else
	flash.now[:notice] = "Username and password didn't match."
	render 'new'
	end
  end

  def destroy
  	reset_session
	redirect_to log_in_path
  end
end
