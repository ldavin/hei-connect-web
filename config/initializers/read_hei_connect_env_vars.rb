# Ugly workaround to create global env variables in openshift

# Source the keys
keys = YAML.load(File.read("#{ENV['OPENSHIFT_DATA_DIR']}/keys.yaml"))

# Set the keys
ENV['HEI_CONNECT_LOG_ENTRIES_KEY'] = keys['HEI_CONNECT_LOG_ENTRIES_KEY']
ENV['HEI_CONNECT_NEW_RELIC_LICENCE_KEY'] = keys['HEI_CONNECT_NEW_RELIC_LICENCE_KEY']