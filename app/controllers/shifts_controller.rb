class ShiftsController < ApplicationController

	def new
		@shift = Shift.new
	end

	def create
		@shift = User.find(params[:user_id]).shifts.new(shift_params)
		if @shift.save
			redirect_to summary_path,
				:flash => { :notice => '#{@shift.user.name} has clocked in!' }
	end

	def edit
		@shift = Shift.find(params[:id])
	end

	def update
		@shift = Shift.find(params[:id])
		@shift.update_attributes(:updated_at => Time.now)
	end

	# def destroy
	# end

	private
	def shift_params
  	params.require(:shift).permit(:note)
  end
end
