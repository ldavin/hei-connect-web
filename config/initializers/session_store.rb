# Use Redis for sessions instead of the cookie-based default
if ENV['WEB_SERVER'] == "true"
	require 'action_dispatch/middleware/session/dalli_store'
	HeiConnectWeb::Application.config.session_store :dalli_store, :memcache_server => 'localhost', :namespace => 'sessions', 
													:key => '_foundation_session', :expire_after => 20.minutes
end