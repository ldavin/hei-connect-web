class CheckCredentialsWorker
  def self.perform(user_id)
    user = User.find_or_initialize_by_id user_id

    if user.unverified?
      response = HeiConnect.validate_credentials 'v1', user

      if response.code == 200
        data = JSON.parse response

        if data['valid'] == true
          user.active!
        else
          user.invalid!
        end
      else
        # Todo: Custom message
        user.invalid!
      end
    end
  end
end