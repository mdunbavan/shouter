class User < ActiveRecord::Base
	has_many :shouts, :dependent => :destroy, :foreign_key => :user_id
	has_many :follows, :dependent => :destroy
  # attr_accessible :title, :body
  	attr_accessible :username
	attr_accessible :username, :password, :email
	attr_accessible :profile_bg, :profile_fg, :profile_image
 	attr_accessible :profile_image_file
	validates_presence_of :username, :email, :password
	validates_length_of :password, :minimum => 6
	validates_length_of :username, :in => 1..40
	validates_uniqueness_of :email, :username, :case_sensitive => false
	validates_presence_of :password, :on => "create"
	validates_format_of :email, :with => /\A[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]+\z/i
	has_and_belongs_to_many :follows
	has_secure_password
	
	validate :username_is_prohibited_for_use?

  def username_is_prohibited_for_use?
    if :username == "kyle" || :username == "admin" || :username == "leo"
      errors.add(:username, "must not use these current admin roles")
    end
  end
  
  after_save :store_image
  IMAGE_STORE = "#{Rails.root}/public/img"
  def image_filename
	return "#{IMAGE_STORE}/#{id}.#{image_type}"
  end
  
  def profile_image=(file_data)
 	unless file_data.blank?
		@file_data = file_data
		self.image_type = file_data.original_filename.split('.').last.downcase
	end
end
  
	def image_uri
		return "/img/#{id}.#{image_type}"
	end
	
# define method to determine if a review has an image on the
# file system at the location specified by image_filename
	def has_image?
		return File.exists? image_filename
	end
	
  
  # after saving other date, store image on file system
# mark store_image method private
	private
	
		def store_image
		if @file_data
			# create directory at IMAGE_STORE if it does not exist
			FileUtils.mkdir_p IMAGE_STORE
			# save image to file location and name from image_filename method
			File.open(image_filename, 'wb') do |f|
			f.write(@file_data.read)
		end
		# nil file_data in memory so it won't be resaved
		@file_data = nil
		end
		end
  
  
	
end
