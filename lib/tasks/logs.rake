namespace :logs do

  desc 'Rotate the Rails logs. (Daily, keep one week, gzipped'
  task :rotate => :environment do
    # Define options
    options = {
        date_time_ext: true,
        date_time_format: '%Y-%m-%d_%H-%M',
        count: 7,
        gzip: true
    }

    # Rotate the logs
    LogRotate.rotate_files(Dir.glob("#{Rails.root}/log/*.log"), options)
  end

end