class FetchScheduleWorker
  include Sidekiq::Worker

  def perform(user_id)
    user = User.find(user_id)

    if user.schedule_planned?
      data = JSON.parse(HeiConnect.get_weeks 'v1', user)

      if data.include? 'error'
        raise data['error']
      end

      data['weeks'].each do |week|
        week_db = Week.find_or_create_by_user_id_and_number(user.id, week['number'])
        week_db.update_attribute :rev, week_db.rev + 1

        week['courses'].each do |course|
          course_db = Course.where(date: Time.zone.parse(course['date']), length: course['length'],
                                   kind: course['type'], group: course['group'],
                                   code: course['code'], name: course['name'],
                                   room: course['room'], teacher: course['teacher'],
                                   week_id: week_db.id).first_or_create
          course_db.update_attribute :week_rev, week_db.rev
        end
      end

      user.schedule_ok!
    end
  end
end