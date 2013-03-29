namespace :maintenance do

  desc 'Enable maintenance mode.'
  task :enable => :environment do
    Rails.cache.write 'maintenance', true
  end

  desc 'Disable maintenance mode.'
  task :disable => :environment do
    Rails.cache.write 'maintenance', nil
  end

end