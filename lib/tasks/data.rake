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

end