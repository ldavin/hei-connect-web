class HeiConnect

  def self.validate_credentials(version, user)
    get_authed_rest_client(version, "validate_credentials", user)
  end

  def self.get_weeks(version, user)
    get_authed_rest_client(version, "schedule", user)
  end

  private

  def self.base_url
    HEI_CONNECT['base']
  end

  def self.get_authed_rest_client(version, action, user)
    RestClient.get "#{base_url}#{version}/#{action}.json", {params: {username: user.ecampus_id, password: user.password}}
  end

end