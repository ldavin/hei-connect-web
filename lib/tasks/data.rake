namespace :data do
  desc 'Delete outdated courses.'
  task :clean_courses => :environment do
    Resque.enqueue CleanCoursesScheduler
  end

  desc 'Schedule an update of every valid user\'s schedule.'
  task :update_schedules => :environment do
    Resque.enqueue UpdateSchedulesScheduler
  end

  desc 'Schedule an update of every valid user\'s sessions (grades and absences).'
  task :update_sessions => :environment do
    Resque.enqueue UpdateSessionsScheduler
  end

  desc 'Schedule an update of the grades for the the valid users\' main session.'
  task :update_grades => :environment do
    Resque.enqueue UpdateGradesScheduler
  end

  desc 'Schedule an update of the absences for the the valid users\' main session.'
  task :update_absences => :environment do
    Resque.enqueue UpdateAbsencesScheduler
  end
end