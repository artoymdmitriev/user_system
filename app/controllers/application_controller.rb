class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_filter :blocked?
  before_action :authenticate_user!

  def blocked?
    if current_user.present? && current_user.is_blocked?
      sign_out current_user
      flash[:error] = "This account has been blocked..."
    end
  end

  def list
  	@users = User.all
  end

  def block
  end

  def unblock
  end
end
