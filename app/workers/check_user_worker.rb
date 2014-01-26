class CheckUserWorker
  extend ApplicationWorker

  @queue = :critical

  def self.update_object *args
    User.find(args.flatten.first).user_update
  end

  def self.perform user_id, username, password, *args
    begin
      checked_user = User.find user_id

      client = Client.new
      begin
        # Try to fetch an existing user with these credentials
        api_user = client.user username, password
        stamp_user = User.new
        stamp_user.token = api_user.token

        api_user = client.user_detailed stamp_user
      rescue RocketPants::NotFound
        # We catch the user not found, but let a "bad credentials" error pop up
        # We try to create the user
        api_user = client.new_user username, password
      end

      checked_user.ecampus_id = api_user.username
      checked_user.token = api_user.token
      checked_user.email = api_user.email
      checked_user.save!
      checked_user.user_ok!

      # User valid, retrieve its info as soon as possible
      Resque.enqueue FetchScheduleWorker, checked_user.id
      Resque.enqueue FetchSessionsWorker, checked_user.id, true
    rescue RocketPants::Unauthenticated
      checked_user.user_failed!
    end
  end
end