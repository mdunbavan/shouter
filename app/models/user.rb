class User < ActiveRecord::Base
	include ActiveModel::MassAssignmentSecurity
	attr_accessor :password
  # attr_accessible :title, :body
  	attr_accessible :username
	attr_accessible :username, :password, :email
	attr_accessible :profile_bg, :profile_fg, :profile_image
	attr_accessible :profile_image_file
	validates_presence_of :username, :email, :password
	validates_uniqueness_of :email, :username, :case_sensitive => false
	validates_presence_of :password, :on => "create"
	validates_format_of :email, :with => /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]+\z/i
	
# 	validates_presence_of :username, :if => :username_is_prohibited_for_use?
# 
# 	def username_is_prohibited_for_use?
#   		:username == "kyle" || :username == "admin" || :username == "leo"
#   		
#   		errors.add(:username, "must not use these current admin roles")
# 	end
	
	validate :username_is_prohibited_for_use?

  def username_is_prohibited_for_use?
    if :username == "kyle" || :username == "admin" || :username == "leo"
      errors.add(:username, "must not use these current admin roles")
    end
  end
	
end
