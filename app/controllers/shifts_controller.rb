class ShiftsController < ApplicationController

	def index
		@users = User.all	#for form
		@shift = Shift.new

		#The rest of this is messy. IT's TERRIBLE, UGH!
		#Get this working and then refactor into a helper function!

		#for the first time we load the page:
		if params[:shift].nil?
			@shifts = Shift.all 
		else
			if params[:shift][:user_id].empty? || params[:shift][:user_id].nil?

				#check if date fields are emtpy
				if params[:shift][:from_date].empty? || params[:shift][:from_date].nil?

					if params[:shift][:to_date].empty? || params[:shift][:to_date].nil?
						#all fields are empty
						@shifts = Shift.all
					else
						#only params[:shift][:to_date] is set
						@shifts = Shift.where("created_at <= ?", params[:shift][:to_date].to_date.end_of_day)
					end

				else

					if params[:shift][:to_date].empty? || params[:shift][:to_date].nil?
						#only params[:shift][:from_date] is set
						@shifts = Shift.where("created_at >= ?", params[:shift][:from_date].to_date.beginning_of_day)
					else
						#both params[:shift][:from_date] AND [:to_date] are set!!
						#but not params[:shift][:user_id]
						@shifts = Shift.where(:created_at => (params[:shift][:from_date].to_date.beginning_of_day)..(params[:shift][:to_date].to_date.end_of_day))
					end

				end

			else

				#check if date fields are emtpy
				if params[:shift][:from_date].empty? || params[:shift][:from_date].nil?

					if params[:shift][:to_date].empty? || params[:shift][:to_date].nil?
						#only params[:shift][:user_id] is set
						@shifts = Shift.where(:user_id => params[:shift][:user_id])
					else
						#only params[:shift][:user_id] and params[:shift][:to_date] is set
						@shifts = Shift.where("user_id = ? AND created_at <= ?", params[:shift][:user_id], params[:shift][:to_date].to_date.end_of_day)
					end

				else

					if params[:shift][:to_date].empty? || params[:shift][:to_date].nil?
						#only params[:shift][:user_id] and params[:shift][:from_date] is set
						@shifts = Shift.where("user_id = ? AND created_at >= ?", params[:shift][:user_id], params[:shift][:from_date].to_date.beginning_of_day)
					else
						#EVERYTHING IS SET!
						@shifts = Shift.where(:created_at => (params[:shift][:from_date].to_date.beginning_of_day)..(params[:shift][:to_date].to_date.end_of_day), :user_id => params[:shift][:user_id])
					end

				end

			end
		end
		#NOTE: prefetching for username of all shifts?
	end

	def show
		@users = User.all	#for form
		@shift = Shift.new
		if params[:user].nil? || params[:user].empty?
			@user = User.new
		else
			#find out if this is an existing shift or a new shift!
			#We'll use @check_shift to figure out:
			# - How to display the form
			# - Where to send the form (create or update?)
			@user = User.find(params[:user][:id])
			@check_shift = Shift.where("created_at == updated_at AND user_id = ?", @user)
		end
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
