if Rails.env.production?
  Resque.redis = Redis.new({host: ENV['REDIS_HOST'], db: ENV['REDIS_DB_JOBS']})
end