# Stream delayed_job logs to logentries
Delayed::Worker.logger = Le.new(YAML.load(File.read("#{ENV['OPENSHIFT_DATA_DIR']}/keys.yaml"))['HEI_CONNECT_LOG_ENTRIES_DJ_KEY'])