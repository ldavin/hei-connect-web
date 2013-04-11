class FetchGradesWorker
  def schedule(user_id, session_id)
    user = User.find user_id
    session = UserSession.find session_id

    if session.grades_session.present?
      user.grades_scheduled!(session.grades_session)
      perform(user_id, session_id)
    end
  end

  private

  def perform(user_id, session_id)
    user = User.find user_id
    session = UserSession.find session_id
    ecampus_id = session.grades_session

    user.grades_updating!(ecampus_id)

    begin
      client = Client.new

      # Fetch the grades to count them
      grades = client.grades user, session

      # We're done here!
      user.grades_ok!(ecampus_id)

      # Because if there's any work, it will be in this worker:
      FetchDetailedGradesWorker.new.schedule user.id, session.id if grades.count != session.grades.count
    rescue
      user.grades_failed!(ecampus_id)
    end
  end

  handle_asynchronously :perform, :queue => 'updates', :priority => 75
end