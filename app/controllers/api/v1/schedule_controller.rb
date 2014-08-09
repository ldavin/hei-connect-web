class Api::V1::ScheduleController < Api::ApiController

  before_filter :require_login, :update_user_api_activity

  def index
    @update = current_user.schedule_update

    if stale? last_modified: [Date.today, @update.updated_at].max, public: false
      @courses = current_user.courses.today.includes(:section, :course_rooms, :course_teachers,
                                                     course_rooms: :room, course_teachers: :teacher)
      respond_to do |format|
        format.json
      end
    end
  end

  def tomorrow
    @update = current_user.schedule_update

    if stale? last_modified: [Date.today, @update.updated_at].max, public: false
      @courses = current_user.courses.tomorrow.includes(:section, :course_rooms, :course_teachers,
                                                        course_rooms: :room, course_teachers: :teacher)
      respond_to do |format|
        format.json { render 'api/v1/schedule/index' }
      end
    end
  end

end
