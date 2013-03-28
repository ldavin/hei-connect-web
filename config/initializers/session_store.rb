# Use Redis for sessions instead of the cookie-based default
if Rails.env.production?
  HeiConnectWeb::Application.config.session_store :redis_store, servers: {path: ENV['OPENSHIFT_DATA_DIR'] + '/redis/socks/redis.sock', db: 1, :namespace => 'sessions'}
else
  HeiConnectWeb::Application.config.session_store :redis_store, servers: {:host => 'localhost', :port => 6379, :namespace => 'sessions'}
end
