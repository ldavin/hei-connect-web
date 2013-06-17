if Rails.env.production? and ENV['VCAP_SERVICES']
  services = JSON.parse(ENV['VCAP_SERVICES'])

  jobs_service = services['redis-2.2'].select { |service| service['name'] == 'redis-jobs'}.first['credentials']
  redis_jobs_store = {host: jobs_service['hostname'], port: jobs_service['port'], password: jobs_service['password']}

  Resque.redis = Redis.new redis_jobs_store
end