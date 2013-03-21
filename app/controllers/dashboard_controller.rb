class DashboardController < ApplicationController
  before_filter :require_login, :refresh_user_data

  def index
    @courses = current_user.courses.current_weeks.includes(:section, :teachers, :rooms)
  end

  def courses
    @courses = current_user.courses.current_weeks.includes(:section, :teachers, :rooms)
  end
end
