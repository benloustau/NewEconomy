class UsersController < ApplicationController

	before_action :authenticate_user!
	before_action :set_user, only: [ :show, :update, :edit]

	def index
	# @users = User.all
	# @user = user.where(id: params[:id]) if params[:id].present?
		if params[:search]
			@users = User.search_for(params[:search])
		else 
			@users = User.all
		end
	end

	def edit
	end

	def show
		@users = User.all
		@hash = Gmaps4rails.build_markers(@users) do |user, marker|
  		marker.lat user.latitude
  		marker.lng user.longitude
		end
	end

	def update
		@user = User.find(params[:id])
		if @user.update(user_params)
			flash[:notice] = "Profile updated"
			redirect_to current_user
		else
			flash[:alert] = "There was a problem"
			render :edit
		end
	end

	def create
  	@user = User.create( user_params )
	end

	def destroy
		@user = User.find(params[:id])
		if @user.destroy
			redirect_to root_path
		else
			flash[:alert] = "Could not delete. Sorry"
			redirect_to users_path
		end
	end
# 	def self.search(search)
#   if search
#     self.where("name like ?", "%#{search}%")
#   else
#     self.all
#   end
# end

private

	def user_params
  		params.require(:user).permit(:avatar,:resume, :username, :fname,
  							:lname, :email, :password, :location, :address, :description, :offering)
	end

	def set_user
		@user = User.find(params[:id])
	end
end