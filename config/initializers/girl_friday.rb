require 'connection_pool'

if ENV['OPENSHIFT_APP_NAME']
  # Fixme: Unsafe. No way on openshift to create private environment variables ?
  uri = URI.parse('redis://redistogo:5905c8e3a33df5e2cc90d61cb6d39ca5@spadefish.redistogo.com:9408/')
  options = {host: uri.host, port: uri.port, password: uri.password}
else
  options = {host: 'localhost', port: 6379}
end
redis_pool = ConnectionPool.new(:size => 5, :timeout => 5) { Redis.new options }

CHECK_CREDENTIALS_QUEUE = GirlFriday::WorkQueue.new(:validate_credentials, :size => 1,
                                                    :store => GirlFriday::Store::Redis,
                                                    :store_config => {:pool => redis_pool}) do |msg|
  CheckCredentialsWorker.perform msg[:user_id]
end

FETCH_SCHEDULE_QUEUE = GirlFriday::WorkQueue.new(:fetch_schedule, :size => 1, :store => GirlFriday::Store::Redis,
                                                 :store_config => {:pool => redis_pool}) do |msg|
  FetchScheduleWorker.perform msg[:user_id]
end