class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_logged_in
    @user_loggin_in ||= !current_user.nil?
  end

  def require_login
    redirect_to root_url unless user_logged_in
  end
end
