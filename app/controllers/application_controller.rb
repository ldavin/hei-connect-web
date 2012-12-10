class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    @current_user ||=
        begin
          User.find(session[:user_id]) if session[:user_id]
        rescue
          session[:user_id] = nil
        end
  end

  def user_logged_in
    @user_loggin_in ||= !current_user.nil?
  end

  def require_login
    redirect_to root_url unless user_logged_in
  end
end
