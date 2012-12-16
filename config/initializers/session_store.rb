require File.join(Rails.root, 'lib', 'openshift_secret_generator.rb')

HeiConnectWeb::Application.config.session_store :cookie_store, :key => initialize_secret(
    :session_store,
    '_heiconnectweb_session'
)

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# HeiConnectWeb::Application.config.session_store :active_record_store
