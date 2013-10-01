if Rails.env.production?
  redis_jobs_store = {host: '10.9.8.2', :db => 1}

  Resque.redis = Redis.new redis_jobs_store
end