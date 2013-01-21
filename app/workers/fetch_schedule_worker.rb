class FetchScheduleWorker
  def perform(user_id)
    user = User.find(user_id)

    if user.schedule_planned?
      client = Client.new
      weeks = client.fetch 'schedule', user, Client::ApiWeek

      weeks.each do |week|
        db_week = Week.find_or_create_by_user_id_and_number(user.id, week.number)
        db_week.update_attribute :rev, db_week.rev + 1

        week.courses.each do |course|
          db_course = Course.where(date: course.date, length: course.length,
                                   kind: course.type, group: course.group,
                                   code: course.code, name: course.name,
                                   room: course.room, teacher: course.teachers.blank? ? nil : course.teachers.join(', '),
                                   week_id: db_week.id).first_or_create
          db_course.update_attribute :week_rev, db_week.rev
        end
      end

      user.schedule_ok!
    end
  end

  handle_asynchronously :perform, :queue => 'fetch_schedules'
end