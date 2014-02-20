class Api::ApiController < ActionController::Base

  before_filter :check_maintenance_mode

  def check_maintenance_mode
    if Feature.maintenance_enabled?
      @error = OpenStruct.new
      @error.code = 503
      @error.message = 'Application is in maintenance'
      render 'api/v1/error', status: 503
    end
  end

  def current_user
    @current_user ||= User.find_by_api_token params[:token]
  end

  def user_logged_in
    @user_loggin_in ||= !current_user.nil?
  end

  def require_login
    unless user_logged_in
      @error = OpenStruct.new
      @error.code = 401
      @error.message = 'Connexion requise'
      render 'api/v1/error', status: 401
    end
  end

  def update_user_api_activity(specific_user = nil)
    user = specific_user || current_user
    user.update_column :api_last_activity, Time.zone.now
  end

end

