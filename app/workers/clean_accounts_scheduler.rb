class CleanAccountsScheduler

  @queue = :critical

  def self.perform *args
    now = DateTime.now
    User.where(token: nil).where('created_at < ?', now - 5.minutes).destroy_all
  end

end