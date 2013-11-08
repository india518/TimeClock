class ShiftsController < ApplicationController

	def index
		@users = User.all	#for form
		@shift = Shift.new

		@shifts = Shift.includes(:user).where(:created_at => ((DateTime.now - DateTime.now.wday).to_date.beginning_of_day)..(DateTime.now + (6 - DateTime.now.wday)).to_date.end_of_day)
	end

	def find_shifts
			#figure out what form fields are given, and query accordingly
			if params[:shift][:user_id].empty?
				if params[:shift][:from_date].empty?
					if params[:shift][:to_date].empty?
						#all fields are empty
						@shifts = Shift.includes(:user).all
					else
						#only :to_date is given
						@shifts = Shift.includes(:user).where("created_at <= ?", params[:shift][:to_date].to_date.end_of_day)
					end
				else
					if params[:shift][:to_date].empty?
						#only :from_date] is given
						@shifts = Shift.includes(:user).where("created_at >= ?", params[:shift][:from_date].to_date.beginning_of_day)
					else
						#both :from_date, :to_date are given
						#but not :user_id
						@shifts = Shift.includes(:user).where(:created_at => (params[:shift][:from_date].to_date.beginning_of_day)..(params[:shift][:to_date].to_date.end_of_day))
					end
				end
			else
				if params[:shift][:from_date].empty?
					if params[:shift][:to_date].empty?
						#only [:user_id] is given
						@shifts = Shift.includes(:user).where(:user_id => params[:shift][:user_id])
					else
						#only [:user_id] and [:to_date] are given
						@shifts = Shift.includes(:user).where("user_id = ? AND created_at <= ?", params[:shift][:user_id], params[:shift][:to_date].to_date.end_of_day)
					end
				else
					if params[:shift][:to_date].empty?
						#only params[:shift][:user_id] and params[:shift][:from_date] is set
						@shifts = Shift.includes(:user).where("user_id = ? AND created_at >= ?", params[:shift][:user_id], params[:shift][:from_date].to_date.beginning_of_day)
					else
						#EVERYTHING IS SET!
						@shifts = Shift.includes(:user).where(:created_at => (params[:shift][:from_date].to_date.beginning_of_day)..(params[:shift][:to_date].to_date.end_of_day), :user_id => params[:shift][:user_id])
					end
				end
			end
	end

	def show
		@users = User.all	#for form
		@shift = Shift.new
		@user = User.new
	end

	def show_clock
		@user = User.find(params[:user][:id])
		@shift = Shift.new
		#find out if this is an existing shift or a new shift!
		#We'll use @check_shift to figure out:
		# - How to display the form
		# - Where to send the form (create or update?)
		@check_shift = Shift.where("created_at == updated_at AND user_id = ?", @user)
	end

	def create
		@shift = User.find(params[:shift][:user_id]).shifts.new(shift_params)
		if @shift.save
			redirect_to summary_path,
				:flash => { :notice => "#{@shift.user.name} has clocked in!" }
		else
			redirect_to summary_path,
				:flash => { :alert => 'Oh noes, problem clocking in!' }
		end
	end

	def update
		@shift = Shift.find(params[:shift][:id])
		if @shift.update_attributes(:updated_at => Time.now)
			redirect_to summary_path,
				:flash => { :notice => "#{@shift.user.name} has clocked out!" }
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
