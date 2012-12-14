class DashboardController < ApplicationController
  before_filter :require_login

  def index
    # First login check
    if current_user.schedule_unknown?
      current_user.schedule_planned!
      FetchScheduleWorker.perform_async current_user.id
    end

    @notes = Note.order('updated_at DESC').limit 5
  end

  def courses
    @weeks = current_user.weeks
  end
end
