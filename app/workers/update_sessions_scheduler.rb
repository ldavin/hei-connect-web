class UpdateSessionsScheduler

  @queue = :critical

  def self.perform *args
    User.find_each(include: :updates) do |user|
      if user.user_ok?
        Delayed::Job.enqueue FetchSessionsWorker.new(user.id, false), priority: ApplicationWorker::PR_FETCH_SESSIONS, queue: ApplicationWorker::QUEUE_REGULAR
      end
    end
  end

end