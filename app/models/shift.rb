class Shift < ActiveRecord::Base
  include ActiveModel::ForbiddenAttributesProtection

  belongs_to :user

  #what kind of validations are useful here?

  #note that 'created_at' is the time the user clocks in...
  def clock_in_time
  	self.created_at.strftime("%H:%M %p")
  end

  #... and 'updated_at' is the time the user clocks out!
  def clock_out_time
  	return nil if self.is_in_progress?
  	self.updated_at.strftime("%H:%M %p")
  end

  def clock_in_date
  	self.created_at.strftime('%B %d %Y')
  end

  # #if we have time, account for shifts that span midnight:
  # def clock_out_date
  # self.updated_at.strftime('%B %d %Y')
  # end

  def is_in_progress?
  	#The way Rails is creating models, the 'updated_at' is always set to 
  	#'created_at' when a new model is created. We have a two options:
  	#Which one is better?
  	self.created_at === self.updated_at
  	#(self.created_at - self.updated_at) === 0
  end

  #May not need; but it may be easier to read code calling this method?
  def is_over?
  	!self.is_in_progress?
  end

  def time_clocked
  	return nil if self.is_in_progress?
  	(self.updated_at - self.created_at)/3600 #convert from seconds to hours
  	#Note to self, for table in view:
  	# sprintf "%.2f", 1.0393477 #=> "1.04"
  end
end
