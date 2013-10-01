class UpdateSchedulesScheduler

  @queue = :critical

  def self.perform *args
    User.find_each(include: :updates) do |user|
      if user.user_ok? and user.last_activity > Time.now - 3.month
        Resque.enqueue FetchScheduleWorker, user.id
      end
    end
  end

end