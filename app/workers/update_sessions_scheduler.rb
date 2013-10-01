class UpdateSessionsScheduler

  @queue = :critical

  def self.perform *args
    User.find_each(include: :updates) do |user|
      if user.user_ok?
        Resque.enqueue FetchSessionsWorker, user.id, false
      end
    end
  end

end