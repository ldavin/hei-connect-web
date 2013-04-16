class CheckUserWorker < ApplicationWorker
  def initialize(user_id, username, password)
    @user_id = user_id
    @username = username
    @password = password

    user = User.find @user_id
    super user.user_update.id
  end

  def perform
    checked_user = User.find @user_id

    client = Client.new
    begin
      # Try to fetch an existing user with these credentials
      api_user = client.user @username, @password
    rescue RocketPants::NotFound
      # We catch the user not found, but let a "bad credentials" error pop up
      # We try to create the user
      api_user = client.new_user @username, @password
    end

    checked_user.ecampus_id = api_user.username
    checked_user.token = api_user.token
    checked_user.save!
    checked_user.user_ok!

    # User valid, retrieve its info as soon as possible
    Delayed::Job.enqueue FetchScheduleWorker.new(checked_user.id), priority: ApplicationWorker::PR_FETCH_SCHEDULE
    Delayed::Job.enqueue FetchSessionsWorker.new(checked_user.id, true), priority: ApplicationWorker::PR_FETCH_SESSIONS
  end
end