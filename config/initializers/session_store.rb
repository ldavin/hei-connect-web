# Use Redis for sessions instead of the cookie-based default
if Rails.env.production?
  SERVICES = JSON.parse(ENV['VCAP_SERVICES'])
  session_service = services['redis-2.2'].select { |service| service['name'] == 'redis-sessions'}.first['credentials']
  REDIS_SESSION_STORE = {host: session_service['hostname'], port: session_service['port'], password: session_service['password']}

  cache_service = services['redis-2.2'].select { |service| service['name'] == 'redis-caches'}.first['credentials']
  REDIS_CACHE_STORE = {host: cache_service['hostname'], port: cache_service['port'], password: cache_service['password']}

  jobs_service = services['redis-2.2'].select { |service| service['name'] == 'redis-jobs'}.first['credentials']
  REDIS_JOB_STORE = {host: jobs_service['hostname'], port: jobs_service['port'], password: jobs_service['password']}
else
  REDIS_SESSION_STORE = {host: 'localhost', port: 6379, namespace: 'sessions'}
  REDIS_CACHE_STORE = {host: 'localhost', port: 6379, namespace: 'cache'}
  REDIS_JOB_STORE = {host: 'localhost', port: 6379, namespace: 'jobs'}
end

HeiConnectWeb::Application.config.session_store :redis_store, servers: REDIS_SESSION_STORE
