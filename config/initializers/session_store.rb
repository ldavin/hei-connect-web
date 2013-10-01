# Use Redis for sessions instead of the cookie-based default
if Rails.env.production?
  redis_session_store = {host: '10.9.8.2', :db => 0}
else
  redis_session_store = {host: 'localhost', port: 6379, namespace: 'sessions'}
end

HeiConnectWeb::Application.config.session_store :redis_store, servers: redis_session_store
