class UsersController < ApplicationController



def follow
:require_user
    @user_id = current_user.id
    @follow_id = params[:follow_id]
    @followed_user = User.find(params[:follow_id])

    
    if !@user_id.blank? || !@follow_id.blank? then
      
      Follow.create( :user_id => @user_id, :follow_id => @follow_id)
      flash.now[:notice] = "You're now following <%= @follow_id %>."
            redirect_to '/' + @followed_user.username

    end  
  end
  
 def unfollow
:require_user
    @followed_user = User.find(params[:follow_id])
    
    @follow = Follow.where(:user_id => current_user.id, :follow_id => params[:follow_id]).first
    @follow.destroy
    flash.now[:notice] = "You have unfollowed <%= @follow_id %>."

    redirect_to '/' + @followed_user.username

  end
  
 

  # GET /users
  # GET /users.json
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])
    @shouts = Shout.order('created_at desc').paginate(:page => params[:page], :per_page => 4)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    session[:user_id] = @user.id

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end
end
