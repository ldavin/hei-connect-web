require 'bugsnag'

Bugsnag.configure do |config|
  config.ignore_classes << 'RocketPants::Error'
end