class ShiftsController < ApplicationController

	def index
		@users = User.all	#for form
		@shift = Shift.new
		if params[:shift][:user_id].nil?
			@shifts = Shift.all
		else
			@shifts = Shift.where(:user_id => params[:shift][:user_id])
		end
		#NOTE: prefetching for username of all shifts?
	end

	def new
		@shift = Shift.new
	end

	def create
		@shift = User.find(params[:user_id]).shifts.new(shift_params)
		if @shift.save
			redirect_to summary_path,
				:flash => { :notice => '#{@shift.user.name} has clocked in!' }
		else
			redirect_to summary_path,
				:flash => { :alert => 'Oh noes, problem clocking in!' }
		end
	end

	def edit
		@shift = Shift.find(params[:id])
	end

	def update
		@shift = Shift.find(params[:id])
		if @shift.update_attributes(:updated_at => Time.now)
			redirect_to summary_path,
				:flash => { :notice => '#{@shift.user.name} has clocked out!' }
		else
			redirect_to summary_path,
				:flash => { :alert => 'Oh noes, problem clocking out!' }
		end
	end

	# def destroy
	# end

	private
	def shift_params
  	params.require(:shift).permit(:note)
  end
end
