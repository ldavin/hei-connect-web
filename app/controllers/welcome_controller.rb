class WelcomeController < ApplicationController
  layout 'public'

  caches_page :about, :status

  def index
    if user_logged_in
      if current_user.user_ok?
        redirect_to dashboard_url ecampus_id: current_user.ecampus_id
      else
        redirect_to validate_users_url
      end
    else
      @user = User.new
    end
  end

  def about
  end

  def status
  end
end
