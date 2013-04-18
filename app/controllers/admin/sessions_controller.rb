# encoding: utf-8
class Admin::SessionsController < AdminController
  layout 'public'
  skip_before_filter :require_admin, except: :destroy

  def index
    @user = User.new
  end

  def create
    params[:user][:ecampus_id].downcase! if params[:user][:ecampus_id]
    @user = User.new(params[:user])

    if User.where(ecampus_id: @user.ecampus_id).any?
      user_db = User.find_by_ecampus_id @user.ecampus_id
      if user_db.authenticate(@user.password) and user_db.admin
        session[:admin_id] = user_db.id
        redirect_to admin_dashboard_url
      else
        redirect_to admin_root_url
      end
    else
      redirect_to admin_root_url
    end
  end

  def destroy
    session[:admin_id] = nil
    redirect_to admin_root_url, notice: "Déconnexion réussie. A bientôt."
  end
end
