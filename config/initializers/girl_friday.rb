CHECK_CREDENTIALS_QUEUE = GirlFriday::WorkQueue.new(:validate_credentials, :size => 1) do |msg|
  CheckCredentialsWorker.perform msg[:user_id]
end

FETCH_SCHEDULE_QUEUE = GirlFriday::WorkQueue.new(:fetch_schedule, :size => 1) do |msg|
  FetchScheduleWorker.perform msg[:user_id]
end