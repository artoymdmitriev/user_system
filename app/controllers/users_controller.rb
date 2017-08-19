class UsersController < ApplicationController
	def block
		user = User.find(params[:id])
		user.is_blocked = true
		user.save
		redirect_to root_path
	end

	def unblock
		user = User.find(params[:id])
		user.is_blocked = false
		user.save
		redirect_to root_path
	end
end
