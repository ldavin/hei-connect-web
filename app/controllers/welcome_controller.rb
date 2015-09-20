require 'rss'

class WelcomeController < ApplicationController
  layout 'public'

  caches_page :about, :status

  def index
    if user_logged_in
      if current_user.user_ok?
        flash[:info] = "Ca fait longtemps qu'on ne t'avait pas vu ! Pendant ton absence, on a arrêté de synchroniser tes données, mais tu es de retour dans les files d'attentes. Tes données toutes fraiches seront visibles dès demain." if (Time.now - 2.month) > current_user.last_activity
        redirect_to dashboard_url ecampus_id: current_user.ecampus_id
      else
        redirect_to validate_users_url
      end
    else
      @user = User.new

      respond_to do |format|
        format.html
      end
    end
  end

  def about
  end

  def status
  end


end
