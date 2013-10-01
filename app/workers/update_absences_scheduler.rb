class UpdateAbsencesScheduler

  @queue = :critical

  def self.perform *args
    User.find_each(include: :updates) do |user|
      if user.user_ok? and user.main_session.present? and user.last_activity > Time.now - 3.month
        Resque.enqueue FetchAbsencesWorker, user.id, user.main_session.id
      end
    end
  end

end