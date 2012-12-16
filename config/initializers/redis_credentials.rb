if ENV['VCAP_SERVICES']
  services = JSON.parse(ENV['VCAP_SERVICES'])
  redis_key = services.keys.select { |svc| svc =~ /redis/i }.first
  redis = services[redis_key].first['credentials']
  REDIS_HOSTNAME = redis['hostname']
  REDIS_PORT = redis['port']
  REDIS_PASSWORD = redis['password']
else
  REDIS_HOSTNAME = ''
  REDIS_PORT = ''
  REDIS_PASSWORD = nil
end