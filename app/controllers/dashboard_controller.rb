class DashboardController < ApplicationController
  before_filter :require_login, :refresh_user_data, :check_ecampus_suffix

  def index
    @courses = current_user.courses.current_weeks

    if stale? current_user, public: false
      respond_to do |format|
        format.html
      end
    end
  end

  def courses
    @courses = current_user.courses.current_weeks

    if stale? current_user, public: false
      respond_to do |format|
        format.html
        format.json { render :json => @courses.collect { |c| c.to_fullcalendar_event } }
        format.xml { render :xml => @courses.collect { |c| c.to_fullcalendar_event } }
      end
    end
  end
end
