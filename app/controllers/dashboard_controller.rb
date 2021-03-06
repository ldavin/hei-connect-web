# encoding: utf-8

class DashboardController < ApplicationController
  before_filter :require_login, :check_ecampus_suffix, :update_user_activity

  def index
    @session = current_user.main_session || UserSession.new
    @updates = [current_user.schedule_update, current_user.sessions_update]

    unless @session.new_record?
      @updates.push current_user.grades_update(@session.grades_session)
      @updates.push current_user.absences_update(@session.absences_session)
    end

    if stale? last_modified: max_timestamp(@updates), public: false
      @courses = current_user.courses.includes(:section, :group, :course_rooms, :course_teachers,
                                               course_rooms: :room, course_teachers: :teacher)
      @grades = @session.grades.includes(:exam)
      @absences = @session.absences

      respond_to do |format|
        format.html
      end
    end
  end

  def courses
    @updates = [current_user.schedule_update]

    flash.now[:alert] = Feature.update_schedule_error_message unless Feature.update_schedule_enabled?

    if stale? last_modified: max_timestamp(@updates), public: false
      @courses = current_user.courses.includes(:section, :group, :course_rooms, :course_teachers,
                                               course_rooms: :room, course_teachers: :teacher)

      respond_to do |format|
        format.html
        format.json { render :json => @courses.collect { |c| c.to_fullcalendar_event } }
        format.xls
      end
    end
  end

  def grades
    @session = get_session params[:year], params[:try]
    @updates = current_user.sessions.collect { |s| current_user.grades_update(s.grades_session) }
    @exams = @session.exams

    flash.now[:alert] = Feature.update_grades_error_message unless Feature.update_grades_enabled?

    if stale? last_modified: max_timestamp(@updates + @exams), public: false
      @grades = @session.grades.includes(:exam, exam: :section)

      respond_to do |format|
        format.html
        format.json { render :json => @grades.collect { |g| g.to_detailed_hash } }
        format.xls
      end
    end
  end

  def update_grades
    @session = get_session params[:year], params[:try]

    if current_user.grades_scheduled?(@session.grades_session)
      flash = {alert: 'La mise à jour est déjà planifiée'}
    else
      flash = {notice: 'Mise à jour programmée'}
      Delayed::Job.enqueue FetchDetailedGradesWorker.new(current_user.id, @session.id),
                           priority: ApplicationWorker::PR_FETCH_DETAILED_GRADES,
                           queue: ApplicationWorker::QUEUE_DETAILED_GRADES
    end

    redirect_to dashboard_grades_path(ecampus_id: current_user.ecampus_id, year: @session.year, try: @session.try), flash
  end

  def absences
    @session = get_session params[:year], params[:try]
    @updates = current_user.sessions.collect { |s| current_user.absences_update(s.absences_session) }

    flash.now[:alert] = Feature.update_absences_error_message unless Feature.update_absences_enabled?

    if stale? last_modified: max_timestamp(@updates), public: false
      @absences = @session.absences.includes(:section)

      respond_to do |format|
        format.html
        format.json { render :json => @absences.collect { |a| a.to_detailed_hash } }
        format.xls
      end
    end
  end

  def update_absences
    @session = get_session params[:year], params[:try]

    if current_user.absences_scheduled?(@session.absences_session)
      flash = {alert: 'La mise à jour est déjà planifiée'}
    else
      flash = {notice: 'Mise à jour programmée'}
      Delayed::Job.enqueue FetchAbsencesWorker.new(current_user.id, @session.id),
                           priority: ApplicationWorker::PR_FETCH_ABSENCES,
                           queue: ApplicationWorker::QUEUE_REGULAR
    end

    redirect_to dashboard_absences_path(ecampus_id: current_user.ecampus_id, year: @session.year, try: @session.try), flash
  end

  private

  def max_timestamp(updates)
    updates.collect { |u| u.updated_at }.max
  end

  def get_session(year, try)
    result = current_user.sessions.select { |s| s.year == year.to_i and s.try == try.to_i }.first

    if result.nil?
      redirect_to dashboard_url ecampus_id: current_user.ecampus_id
    else
      result
    end
  end
end
