# Use Redis for sessions instead of the cookie-based default
if Rails.env.production? and ENV['VCAP_SERVICES']
  services = JSON.parse(ENV['VCAP_SERVICES'])
  session_service = services['redis-2.2'].select { |service| service['name'] == 'redis-sessions'}.first['credentials']
  redis_session_store = {host: session_service['hostname'], port: session_service['port'], password: session_service['password']}
else
  redis_session_store = {host: 'localhost', port: 6379, namespace: 'sessions'}
end

HeiConnectWeb::Application.config.session_store :redis_store, servers: redis_session_store
