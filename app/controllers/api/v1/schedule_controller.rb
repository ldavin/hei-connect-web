class Api::V1::ScheduleController < Api::ApiController

  before_filter :require_login, :update_user_api_activity

  def index
    @courses = current_user.courses.today.includes(:section, :group, :course_rooms, :course_teachers,
                                                   course_rooms: :room, course_teachers: :teacher)
    @update = current_user.schedule_update
  end

  def tomorrow
    @courses = current_user.courses.tomorrow.includes(:section, :group, :course_rooms, :course_teachers,
                                                      course_rooms: :room, course_teachers: :teacher)
    @update = current_user.schedule_update

    render 'api/v1/schedule/index'
  end

end
