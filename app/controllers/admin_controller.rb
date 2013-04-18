class AdminController < ActionController::Base
  protect_from_forgery
  before_filter :require_admin

  helper_method :current_admin

  def current_admin
    @current_admin ||=
        begin
          u = User.find session[:admin_id] if session[:admin_id]
          u = nil unless u.admin
          u
        rescue
          session[:user_id] = nil
        end
  end

  def admin_logged_in
    @user_loggin_in ||= !current_admin.nil?
  end

  def require_admin
    redirect_to root_url unless admin_logged_in
  end
end
