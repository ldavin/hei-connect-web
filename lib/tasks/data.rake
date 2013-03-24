namespace :data do

  desc 'Delete outdated courses.'
  task :clean_courses => :environment do
    date = Date.today
    date = date - date.wday + 1
    Course.where('date < ?', date).destroy_all
  end

end