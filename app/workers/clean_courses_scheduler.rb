class CleanCoursesScheduler

  def perform
    # Only clean courses on sundays
    if Date.today.wday == 0
      date = Date.today
      date = date - date.wday + 1
      Course.where('date < ?', date).destroy_all
    end
  end

end