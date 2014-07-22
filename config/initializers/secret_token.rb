token = case Rails.env
          when 'development', 'test'
            "123456789012345678901234567890"
          else
            ENV['APP_SECRET_TOKEN']
        end

HeiConnectWeb::Application.config.secret_token = token