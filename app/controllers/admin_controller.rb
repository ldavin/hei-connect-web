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

  def require_admin
    redirect_to root_url if current_admin.nil?
  end

  def check_entity
    entity = params[:entity].to_sym
    if Admin::EntityController::ENTITIES.include? entity
      @klass = Admin::EntityController::ENTITIES[entity]
      @klass_path = entity
    else
      redirect_to admin_root_url
    end
  end
end
