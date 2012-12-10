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
      CheckCredentialsWorker.perform_async @user.id
      redirect_to validate_users_url
    else
      render action: :new
    end
  end

  def validate
    case current_user.state
      when User::STATE_ACTIVE
        redirect_to root_url, notice: "Les identifiants de votre compte ont été validés."
      when User::STATE_INVALID
        current_user.delete
        session[:user_id] = nil
        redirect_to root_url, alert: "Les identifiants que vous avez entré ne permettent pas de vous connecter" +
            " à e-campus, ou bien e-campus ne répond pas. Le compte a été supprimé, merci de ré-essayer."
    end
  end
end
