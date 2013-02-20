class SessionsController < ApplicationController
  # GET /sessions
  # GET /sessions.json
  def index
    if logged_in?
      redirect_to :controller=>'shouts', :action => 'index'
    else
      redirect_to :controller=>'sessions', :action => 'new'
    end
  end

  # GET /sessions/new
  # GET /sessions/new.json
  def new
    if logged_in?
    redirect_to :controller=>'shouts', :action => 'index'
    end
  end

  # POST /sessions
  # POST /sessions.json
  def create
    if user = User.find_by_username(@username).try(:authenticate, params[:password])
	session[:user_id] = user.id
	end
  end

  # DELETE /sessions/1
  # DELETE /sessions/1.json
  def destroy
    reset_session
    redirect_to root_path
  end
end
