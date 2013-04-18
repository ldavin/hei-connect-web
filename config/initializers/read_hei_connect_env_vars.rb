# Ugly workaround to load our env variables in openshift

# Source the keys
HC_ENV_KEYS = YAML.load(File.read("#{ENV['OPENSHIFT_DATA_DIR']}/keys.yaml"))