case Rails.env
  when 'development', 'test'
    HeiConnectWeb::Application.config.secret_token = '123456789012345678901234567890'
    HeiConnectWeb::Application.config.cookie_secret = '123456789012345678901234567890'
    HeiConnectWeb::Application.config.secret_key_base = '123456789012345678901234567890'
  else
    HeiConnectWeb::Application.config.secret_token = ENV['APP_SECRET_TOKEN']
    HeiConnectWeb::Application.config.cookie_secret = ENV['APP_COOKIE_KEY']
    HeiConnectWeb::Application.config.secret_key_base = ENV['APP_COOKIE_KEY']
end