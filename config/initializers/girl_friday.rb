require 'connection_pool'

if ENV['OPENSHIFT_GEAR_DIR']
  redis = Redis.new path: "#{ENV['OPENSHIFT_GEAR_DIR']}tmp/redis.sock"
else
  redis = Redis.new host: 'localhost', port: 6379
end
redis_pool = ConnectionPool.new(:size => 5, :timeout => 5) { redis }

CHECK_CREDENTIALS_QUEUE = GirlFriday::WorkQueue.new(:validate_credentials, :size => 1,
                                                    :store => GirlFriday::Store::Redis,
                                                    :store_config => {:pool => redis_pool}) do |msg|
  CheckCredentialsWorker.perform msg[:user_id]
end

FETCH_SCHEDULE_QUEUE = GirlFriday::WorkQueue.new(:fetch_schedule, :size => 1, :store => GirlFriday::Store::Redis,
                                                 :store_config => {:pool => redis_pool}) do |msg|
  FetchScheduleWorker.perform msg[:user_id]
end