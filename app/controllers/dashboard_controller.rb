# encoding: utf-8

class DashboardController < ApplicationController
  before_filter :require_login, :check_ecampus_suffix, :update_user_activity

  def index
    @courses = current_user.courses.current_weeks
    @session = current_user.main_session || UserSession.new
    @updates = [current_user.schedule_update, current_user.sessions_update]
    @updates.push current_user.grades_update(@session.grades_session) unless @session.new_record?

    if stale? current_user, public: false
      respond_to do |format|
        format.html
      end
    end
  end

  def courses
    @courses = current_user.courses.current_weeks
    @updates = [current_user.schedule_update]

    if stale? current_user, public: false
      respond_to do |format|
        format.html
        format.json { render :json => @courses.collect { |c| c.to_fullcalendar_event } }
        format.xml { render :xml => @courses.collect { |c| c.to_fullcalendar_event } }
      end
    end
  end

  def grades
    @session = get_sessions params[:year], params[:try]
    @updates = current_user.sessions.collect { |s| current_user.grades_update(s.grades_session) }
  end

  def update_grades
    @session = get_sessions params[:year], params[:try]

    # We keep a 2 hours safety
    if current_user.grades_last_update(@session.grades_session) + 2.hours > DateTime.now.in_time_zone
      flash = {alert: 'Mise à jour annulée, vous devez attendre au moins deux heures avant de forcer une nouvelle mise à jour'}
    else
      flash = {notice: 'Mise à jour programmée'}
      Delayed::Job.enqueue FetchDetailedGradesWorker.new(current_user.id, @session.id),
                           priority: ApplicationWorker::PR_FETCH_DETAILED_GRADES
    end

    redirect_to dashboard_grades_path(ecampus_id: current_user.ecampus_id, year: @session.year, try: @session.try), flash
  end

  private

  def get_sessions(year, try)
    begin
      current_user.sessions.where(year: year.to_i, try: try.to_i).first!
    rescue
      redirect_to dashboard_grades_path(ecampus_id: current_user.ecampus_id, year: current_user.main_session.year,
                                        try: current_user.main_session.try)
    end
  end
end
