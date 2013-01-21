class DashboardController < ApplicationController
  before_filter :require_login, :refresh_user_data

  def index
    @notes = Note.order('updated_at DESC').limit 3
  end

  def courses
    @weeks = current_user.weeks
  end
end
