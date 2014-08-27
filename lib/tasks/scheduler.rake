namespace :scheduler do

  desc 'Schedule a schedules update'
  task :update_schedules => :environment do
    Delayed::Job.enqueue UpdateSchedulesScheduler.new, priority: ApplicationWorker::PR_HIGHEST, queue: ApplicationWorker::QUEUE_REGULAR
  end

  desc 'Schedule an absences update'
  task :update_absences => :environment do
    Delayed::Job.enqueue UpdateAbsencesScheduler.new, priority: ApplicationWorker::PR_HIGHEST, queue: ApplicationWorker::QUEUE_REGULAR
  end

  desc 'Schedule a grades update'
  task :update_grades => :environment do
    Delayed::Job.enqueue UpdateGradesScheduler.new, priority: ApplicationWorker::PR_HIGHEST, queue: ApplicationWorker::QUEUE_REGULAR
  end

  desc 'Schedule a sessions update'
  task :update_sessions => :environment do
    Delayed::Job.enqueue UpdateSessionsScheduler.new, priority: ApplicationWorker::PR_HIGHEST, queue: ApplicationWorker::QUEUE_REGULAR
  end


  desc 'Schedule an account cleaning (delete invalid accounts)'
  task :clean_accounts => :environment do
    Delayed::Job.enqueue CleanAccountsScheduler.new, priority: ApplicationWorker::PR_HIGHEST, queue: ApplicationWorker::QUEUE_REGULAR
  end

  desc 'Schedule a courses cleaning (delete old courses)'
  task :clean_courses => :environment do
    Delayed::Job.enqueue CleanCoursesScheduler.new, priority: ApplicationWorker::PR_HIGHEST, queue: ApplicationWorker::QUEUE_REGULAR
  end

end
