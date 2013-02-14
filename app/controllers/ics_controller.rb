class IcsController < ApplicationController
  def show
    begin
      user = User.find_by_ics_key! params[:key]
    rescue
      redirect_to root_url, alert: "Impossible de trouver de calendrier correspondant."
      return
    end

    user.update_schedule! if user.expired_schedule?

    respond_to do |format|
      format.ics do
        calendar = RiCal.Calendar do |cal|
          user.courses.current_weeks.includes(:section, :teachers, :rooms).each do |course|
            cal.event do |event|
              event.dtstart = course.date
              event.dtend = course.date + course.length.minutes
              event.summary = course.name
              event.description = course.description
              event.location = course.place
              event.created = course.created_at.to_datetime
              event.last_modified = course.updated_at.to_datetime
            end
          end
        end

        render :text => calendar.to_s.gsub!(/\n/, "\r\n"), :content_type => 'text/calendar'
      end
    end
  end
end
