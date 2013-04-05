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
      FetchScheduleWorker.new.perform user.id if user.user_ok?
    end
  end

  desc 'Schedule an update of every valid user\'s sessions (grades and absences).'
  task :update_sessions => :environment do
    User.find_each(include: :updates, include: :sessions) do |user|
      FetchSessionsWorker.new.perform user.id if user.user_ok?
    end
  end

  desc 'Schedule an update of every valid user\'s grades.'
  task :update_grades => :environment do
    User.find_each(include: :updates) do |user|
      FetchGradesWorker.new.perform user.id, user.main_session.id if user.user_ok?
    end
  end

end