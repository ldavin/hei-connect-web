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
        calendar = Icalendar::Calendar.new
        user.courses.current_weeks.each do |course|
          calendar.add_event course.to_ics
        end
        calendar.publish
        render :text => calendar.to_ical, :content_type => 'text/calendar'
      end
    end
  end
end
