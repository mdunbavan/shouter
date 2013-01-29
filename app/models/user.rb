class User < ActiveRecord::Base
	include ActiveModel::MassAssignmentSecurity
	attr_accessor :password
  # attr_accessible :title, :body
  	attr_accessible :username
	attr_accessible :username, :password, :email
end
