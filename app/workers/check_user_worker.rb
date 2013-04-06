class CheckUserWorker
  def perform(id, username, password)
    checked_user = User.find_or_initialize_by_id id

    if not checked_user.new_record? and checked_user.user_unknown?
      checked_user.user_updating!
      begin
        client = Client.new

        begin
          # Try to fetch an existing user with these credentials
          api_user = client.user username, password
        rescue RocketPants::NotFound
          # We catch the user not found, but let a "bad credentials" error pop up
          # We try to create the user
          api_user = client.new_user username, password
        end

        checked_user.ecampus_id = api_user.username
        checked_user.token = api_user.token
        checked_user.save!
        checked_user.user_ok!

        # User valid, retrieve its info as soon as possible
        FetchScheduleWorker.new.perform checked_user.id
        FetchSessionsWorker.new.perform checked_user.id, true
      rescue
        checked_user.user_failed!
      end
    end
  end

  handle_asynchronously :perform, :queue => 'registrations', :priority => 100
end