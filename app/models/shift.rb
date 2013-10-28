class Shift < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  #what kind of validations are useful here?

  #note that 'created_at' is the time the user clocks in...
  def clock_in_time
  	self.created_at
  end

  #... and 'updated_at' is the time the user clocks out!
  def clock_out_time
  	self.updated_at
  end
end
