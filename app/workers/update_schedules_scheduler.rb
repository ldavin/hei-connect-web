class UpdateSchedulesScheduler

  def perform
    User.find_each(include: :updates) do |user|
      if user.user_ok? and user.last_activity > Time.now - 2.month
        Delayed::Job.enqueue FetchScheduleWorker.new(user.id),
                             priority: ApplicationWorker::PR_FETCH_SCHEDULE,
                             queue: ApplicationWorker::QUEUE_REGULAR
      end
    end
  end

end