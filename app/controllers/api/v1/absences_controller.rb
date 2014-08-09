class Api::V1::AbsencesController < Api::ApiController

  before_filter :require_login, :update_user_api_activity

  def index
    session = current_user.main_session
    @update = current_user.absences_update(session.absences_session)

    if stale? last_modified: @update.updated_at, public: false
      @absences = session.absences.includes(:section).order('date DESC')

      respond_to do |format|
        format.json
      end
    end
  end

end
