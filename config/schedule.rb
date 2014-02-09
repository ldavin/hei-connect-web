# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

every 5.minutes do
  runner "Delayed::Job.enqueue CleanAccountsScheduler.new, priority: ApplicationWorker::PR_HIGHEST, queue: ApplicationWorker::QUEUE_REGULAR"
end

every 1.day, at: '1:00am' do
  runner "Delayed::Job.enqueue UpdateAbsencesScheduler.new, priority: ApplicationWorker::PR_HIGHEST, queue: ApplicationWorker::QUEUE_REGULAR"
end

every 1.day, at: '3:00am' do
  runner "Delayed::Job.enqueue UpdateGradesScheduler.new, priority: ApplicationWorker::PR_HIGHEST, queue: ApplicationWorker::QUEUE_REGULAR"
end

every 1.day, at: '2:00pm' do
  runner "Delayed::Job.enqueue UpdateSchedulesScheduler.new, priority: ApplicationWorker::PR_HIGHEST, queue: ApplicationWorker::QUEUE_REGULAR"
end

every 2.day, at: '11:00pm' do
  system "script/delayed_job stop"
  system "script/delayed_job --queue=regular -i=1 start"
  system "script/delayed_job --queues=regular,grades -i=2 start"
end

every :sunday do
  runner "Delayed::Job.enqueue CleanCoursesScheduler.new, priority: ApplicationWorker::PR_HIGHEST, queue: ApplicationWorker::QUEUE_REGULAR"
end

every :sunday do
  runner "Delayed::Job.enqueue UpdateSessionsScheduler.new, priority: ApplicationWorker::PR_HIGHEST, queue: ApplicationWorker::QUEUE_REGULAR"
end

