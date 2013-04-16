namespace :data do
  desc 'Delete outdated courses.'
  task :clean_courses => :environment do
    date = Date.today
    date = date - date.wday + 1
    Course.where('date < ?', date).destroy_all
  end

  desc 'Schedule an update of every valid user\'s schedule.'
  task :update_schedules => :environment do
    User.find_each(include: :updates) do |user|
      if user.user_ok?
        Delayed::Job.enqueue FetchScheduleWorker.new(user.id), priority: ApplicationWorker::PR_FETCH_SCHEDULE
      end
    end
  end

  desc 'Schedule an update of every valid user\'s sessions (grades and absences).'
  task :update_sessions => :environment do
    User.find_each(include: :updates) do |user|
      if user.user_ok?
        Delayed::Job.enqueue FetchSessionsWorker.new(user.id), priority: ApplicationWorker::PR_FETCH_SESSIONS
      end
    end
  end

  desc 'Schedule an update the grades for the the valid users\' main session.'
  task :update_grades => :environment do
    User.find_each(include: :updates) do |user|
      if user.user_ok? and user.main_session.present?
        Delayed::Job.enqueue FetchGradesWorker.new(user.id, user.main_session.id),
                             priority: ApplicationWorker::PR_FETCH_GRADES
      end
    end
  end
end