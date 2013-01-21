class CheckCredentialsWorker
  def perform(user_id)
    checked_user = User.find_or_initialize_by_id user_id

    if checked_user.unverified?
      begin
        client = Client.new
        details = client.fetch 'user', checked_user, Client::ApiUser
        checked_user.update_attributes! ecampus_id: details.id #, student_id: details.student_id, user_id: details.user_id
        checked_user.active!
      rescue RocketPants::Unauthenticated
        checked_user.invalid!
      end
    end
  end

  handle_asynchronously :perform, :queue => 'check_credentials'
end