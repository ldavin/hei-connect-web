class UpdateUserWorker
  extend ApplicationWorker

  @queue = :high

  def self.update_object *args
    User.find(args.flatten.first).user_update
  end

  def self.perform user_id, *args
    begin
      checked_user = User.find user_id

      client = Client.new
      api_user = client.user_detailed checked_user

      checked_user.ecampus_id = api_user.username
      checked_user.token = api_user.token
      checked_user.email = api_user.email
      checked_user.save!
      checked_user.user_ok!

    rescue RocketPants::Unauthenticated
      checked_user.user_failed!
    end
  end
end