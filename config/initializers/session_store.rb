# Use Redis for sessions instead of the cookie-based default
HeiConnectWeb::Application.config.session_store :redis_store, servers: {host: ENV['REDIS_HOST'], db: ENV['REDIS_DB_SESSIONS']}
