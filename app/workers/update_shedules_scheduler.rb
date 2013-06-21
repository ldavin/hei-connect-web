class UpdateSchedulesScheduler

  @queue = :critical

  def self.perform *args
    User.find_each(include: :updates) do |user|
      if user.user_ok?
        Resque.enqueue FetchScheduleWorker, user.id
      end
    end
  end

end