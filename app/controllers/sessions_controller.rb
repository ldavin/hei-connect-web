# encoding: utf-8
class SessionsController < ApplicationController
  layout 'public'

  def new
  end

  def create
    user = User.authenticate(params[:ecampus_id], params[:password])

    if user
      session[:user_id] = user.id
      redirect_to root_url
    else
      render action: :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Déconnexion réussie. A bientôt."
  end
end
