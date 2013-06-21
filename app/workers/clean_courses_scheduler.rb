class CleanCoursesScheduler

  @queue = :critical

  def self.perform *args
    date = Date.today
    date = date - date.wday + 1
    Course.where('date < ?', date).destroy_all
  end

end