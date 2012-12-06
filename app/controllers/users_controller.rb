# encoding: utf-8
class UsersController < ApplicationController
  layout 'public'
  before_filter :require_login, only: :validate

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      session[:user_id] = @user.id
      redirect_to validate_users_url
    else
      render action: :new
    end
  end

  def validate
    # This is a dirty implementation yet:
    # The API call will have to be moved in a background job
    response = HeiConnect.validate_credentials 'v1', current_user

    if response.code == 200
      data = JSON.parse response

      if data['valid'] == true
        current_user.update_attribute(:login_checked, true)
        redirect_to root_url, notice: "Les identifiants de votre compte ont été validés."
      else
        current_user.delete
        session[:user_id] = nil
        redirect_to root_url, alert: "Les identifiants que vous avez entré ne permettent pas de vous connecter" +
            " à e-campus. Le compte a été supprimé, merci de vous ré-inscrire."
      end
    else
      session[:user_id] = nil
      redirect_to root_url, alert: "L'API n'a pas répondu correctement. E-campus est peut être hors-ligne ou a" +
          " été mis à jour. Vous avez été déconnecté. Veuillez re-essayer plus tard."
    end
  end
end
