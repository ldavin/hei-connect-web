class CleanCoursesScheduler

  def perform
    date = Date.today
    date = date - date.wday + 1
    Course.where('date < ?', date).destroy_all
  end

end