# encoding: utf-8
class UsersController < ApplicationController
  before_filter :require_login, only: :validate

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])

    if User.where(:ecampus_id => @user.ecampus_id).any?
      authed_user = User.authenticate @user.ecampus_id, @user.password
      if authed_user
        session[:user_id] = authed_user.id
        redirect_to root_url
      else
        flash.now[:alert] = 'Identifiants erronés'
        render action: :new
      end
    else
      if @user.save
        session[:user_id] = @user.id
        redirect_to validate_users_url
      else
        render action: :new
      end
    end
  end

  def validate
    case current_user.user_state
      when Update::STATE_UNKNOWN
        CheckUserWorker.new.perform current_user.id
      when Update::STATE_OK
        redirect_to root_url, notice: "Les identifiants de votre compte ont été validés."
      when Update::STATE_FAILED
        current_user.delete
        session[:user_id] = nil
        redirect_to root_url, alert: "Les identifiants que vous avez entré ne permettent pas de vous connecter" +
            " à e-campus, ou bien e-campus ne répond pas. Le compte a été supprimé, merci de ré-essayer."
    end
  end
end
