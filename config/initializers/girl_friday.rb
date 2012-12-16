require 'connection_pool'

if ENV['VCAP_SERVICES']
  services = JSON.parse(ENV['VCAP_SERVICES'])
  redis_key = services.keys.select { |svc| svc =~ /redis/i }.first
  redis = services[redis_key].first['credentials']
  REDIS_CONF = {host: redis['hostname'], port: redis['port'], password: redis['password']}
else
  REDIS_CONF = {host: 'localhost', port: 6379}
end
redis_pool = ConnectionPool.new(:size => 5, :timeout => 5) { Redis.new REDIS_CONF }

CHECK_CREDENTIALS_QUEUE = GirlFriday::WorkQueue.new(:validate_credentials, :size => 1,
                                                    :store => GirlFriday::Store::Redis,
                                                    :store_config => {:pool => redis_pool}) do |msg|
  CheckCredentialsWorker.perform msg[:user_id]
end

FETCH_SCHEDULE_QUEUE = GirlFriday::WorkQueue.new(:fetch_schedule, :size => 1, :store => GirlFriday::Store::Redis,
                                                 :store_config => {:pool => redis_pool}) do |msg|
  FetchScheduleWorker.perform msg[:user_id]
end