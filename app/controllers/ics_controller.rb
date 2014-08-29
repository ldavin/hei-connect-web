class IcsController < ApplicationController
  def show
    begin
      user = User.find_by_ics_key! params[:key]
    rescue
      render nothing: true, status: 404, layout: false
      return
    end

    update_ics_user_activity user
    @update = user.schedule_update

    if stale? last_modified: @update.updated_at, public: false
      @courses = user.courses.includes(:section, :group, :course_rooms, :course_teachers,
                                       course_rooms: :room, course_teachers: :teacher)

      respond_to do |format|
        format.ics do
          calendar =
              Rails.cache.fetch ['ics', 'v1', user, @courses] do
                cal = RiCal.Calendar

                @courses.each do |course|
                  cal.add_subcomponent course.to_ical_event
                end

                cal.to_s.gsub!(/\n/, "\r\n")
              end

          render :text => calendar, :content_type => 'text/calendar'
        end
      end
    end
  end
end
