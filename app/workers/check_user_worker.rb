class CheckUserWorker
  def perform(user_id)
    checked_user = User.find_or_initialize_by_id user_id

    if not checked_user.new_record? and checked_user.user_unknown?
      checked_user.user_updating!
      begin
        client = Client.new
        details = client.fetch 'user', checked_user, Client::ApiUser
        checked_user.update_attributes! ecampus_id: details.id, ecampus_student_id: details.student_id, ecampus_user_id: details.user_id
        checked_user.user_ok!
      rescue RocketPants::Unauthenticated
        checked_user.user_failed!
      end
    end
  end

  handle_asynchronously :perform, :queue => 'check_user'
end