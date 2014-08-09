class Api::V1::GradesController < Api::ApiController

  before_filter :require_login, :update_user_api_activity

  def index
    session = current_user.main_session
    exams = session.exams
    @update = current_user.grades_update(session.grades_session)

    if stale? last_modified: max_timestamp([@update] + exams), public: false
      @grades = session.grades.includes(:exam, exam: :section).order('exams.date DESC').limit(20)

      respond_to do |format|
        format.json
      end
    end
  end

  private

  def max_timestamp(updates)
    updates.collect { |u| u.updated_at }.max
  end

end
