class User < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  has_many :shifts
  
  validates :first_name,	:last_name,	:presence		=> true,
																			:length			=> { :within => 1..50 }

	def name
		"#{self.first_name} #{self.last_name}"
	end																		
end
