# Stream delayed_job logs to logentries
if Rails.env.production?
  Delayed::Worker.logger = Le.new(
      YAML.load(File.read("#{ENV['OPENSHIFT_DATA_DIR']}/keys.yaml"))['HEI_CONNECT_LOG_ENTRIES_DJ_KEY'])
end