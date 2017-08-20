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

	def delete
		user = User.find(params[:id])
    if(user.id == current_user.id)
      user.delete
      redirect_to '/users/sign_in'
    else
      user.delete
      redirect_to root_path
    end
	end
end
