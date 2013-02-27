class UsersController < ApplicationController

  def follow
	:require_user
    @user_id = current_user.id
    @follow_id = params[:follow_id]
    @followed_user = User.find(params[:follow_id])

    
    if !@user_id.blank? || !@follow_id.blank? then
      
      Follow.create( :user_id => @user_id, :follow_id => @follow_id)
      flash.now[:notice] = "You're now following <%= @follow_id %>."
            redirect_to @followed_user

    end  
  end
  def unfollow
:require_user
    @followed_user = User.find(params[:follow_id])
    
    @follow = Follow.where(:user_id => current_user.id, :follow_id => params[:follow_id]).first
    @follow.destroy
    flash.now[:notice] = "You have unfollowed <%= @follow_id %>."

    redirect_to @followed_user

  end
  def following
:require_user
   @user = User.find_by_username(params[:username])

    #Array to save all of the follow information
    @following_users = Array.new
    
    #Extracting the follow_ids out of this array
    @user.follows.each do |i|
      @following_users.push i.follow_id
    end
    
    #getting the users whose follow id is the same as the follow_id
    @following = User.find_all_by_id(@following_users)

    @shouts = Shout.order('created_at desc').paginate(:page => params[:page], :per_page => 20)
    
    respond_to do |format|
      format.html # profile.html.erb
      
    end

  end
  def followers
:require_user
   @user = User.find_by_username(params[:username])

    #Array to save all of the follow information
    @following_users = Array.new
    
    #Extracting the follow_ids out of this array
    @user.reverse_follows.each do |i|
      @following_users.push i.follow_id
    end
    
    #getting the users whose follow id is the same as the follow_id
    @followers = User.find_all_by_id(@following_users)

    @shouts = Shout.order('created_at desc').paginate(:page => params[:page], :per_page => 20)
    
    respond_to do |format|
      format.html # profile.html.erb
      
    end
    
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
    @user = User.find_by_username(params[:id])
    
    #Array to save all of the follow information
    @following_users = Array.new
    
    #Extracting the follow_ids out of this array
    @user.follows.each do |i|
      @following_users.push i.follow_id
    end
    
    #getting the users whose follow id is the same as the follow_id
    @followed_users = User.find_all_by_id(@following_users)

    #Array of Followers
    @followers = Array.new
    
    #Extracting the follow_ids out of the reverse_followers array
    @user.reverse_follows.each do |i|
      @followers.push i.follow_id
    end
    
    @shouts = Shout.order('created_at desc').paginate(:page => params[:page], :per_page => 4)

    if current_user
    	@already_following = false
    	current_user.follows.each do |follow|
    		if follow.follow == @user
    			@already_following = true
    			break
    		end
    	end
    	
    end

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
    if @user.save
		session[:user_id] = @user.id
		redirect_to shouts_path
	else
		render 'new'
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
