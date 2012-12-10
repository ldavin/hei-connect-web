# encoding: utf-8
class SessionsController < ApplicationController
  layout 'public'

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Déconnexion réussie. A bientôt."
  end
end
