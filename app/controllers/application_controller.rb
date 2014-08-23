class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :check_maintenance_mode
  helper_method :current_user, :user_logged_in

  def check_maintenance_mode
    if Feature.maintenance_enabled?
      session[:user_id] = nil if user_logged_in
      render file: 'public/maintenance', layout: false, status: 503
    end
  end

  def current_user
    @current_user ||=
        begin
          User.find session[:user_id], include: [:updates, :sessions] if session[:user_id]
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

  def check_ecampus_suffix
    if current_user.ecampus_id != params[:ecampus_id]
      redirect_to dashboard_url ecampus_id: current_user.ecampus_id
    end
  end

  def update_user_activity(specific_user = nil)
    user = specific_user || current_user
    user.update_column :last_activity, Time.zone.now
  end

  def update_ics_user_activity(specific_user = nil)
    user = specific_user || current_user
    user.update_column :ics_last_activity, Time.zone.now
  end

  def set_admin_locale
    I18n.locale = :en
  end
end
