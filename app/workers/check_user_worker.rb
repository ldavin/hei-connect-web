class CheckUserWorker
  def perform(id, username, password)
    checked_user = User.find_or_initialize_by_id id

    if not checked_user.new_record? and checked_user.user_unknown?
      checked_user.user_updating!
      begin
        client = Client.new
        api_user = client.new_user username, password
        checked_user.ecampus_id = api_user.username
        checked_user.token = api_user.token
        checked_user.save!
        checked_user.user_ok!

        # User valid, retrieve its info as soon as possible
        FetchScheduleWorker.new.perform checked_user.id
      rescue
        checked_user.user_failed!
      end
    end
  end

  handle_asynchronously :perform, :queue => 'registrations', :priority => 10
end