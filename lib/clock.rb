require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'clockwork'

include Clockwork

configure do |config|
  config[:tz] = 'Paris'
end

every(1.hour, 'schedules update', :at => ['06:00', '18:00']) {
  Resque.enqueue UpdateSchedulesScheduler
}

every(1.day, 'absences update', :at => '02:00') {
  Resque.enqueue UpdateAbsencesScheduler
}

every(1.day, 'grades update', :at => '04:00') {
  Resque.enqueue UpdateGradesScheduler
}

every(1.week, 'courses cleaning') {
  Resque.enqueue CleanCoursesScheduler
}

every(1.week, 'sessions update') {
  Resque.enqueue UpdateSessionsScheduler
}