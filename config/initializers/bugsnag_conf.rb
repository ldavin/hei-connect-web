require 'bugsnag'

Bugsnag.configure do |config|
  config.notify_release_stages = ['production']
  config.ignore_classes << 'RocketPants::Error'
end