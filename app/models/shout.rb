class Shout < ActiveRecord::Base
	belongs_to :user
  attr_accessible :content, :user_id
  validates_length_of :content, :in => 1..140
end
