class FetchGradesWorker < ApplicationWorker
  def initialize(user_id, session_id)
    @user_id = user_id
    @session_id = session_id

    user = User.find @user_id
    session = UserSession.find @session_id
    super user.grades_update(session.grades_session).id
  end

  def perform
    user = User.find @user_id
    session = UserSession.find @session_id

    # Fetch the grades to count them
    client = Client.new
    grades = client.grades user, session

    # Because if there's any work, it will be in this worker:
    if grades.count != session.grades.count
      @scheduling_detailed_update = true
      Delayed::Job.enqueue FetchDetailedGradesWorker.new(user.id, session.id),
                           priority: ApplicationWorker::PR_FETCH_DETAILED_GRADES
    end
  end

  def success(job)
    super job if @scheduling_detailed_update.nil?
  end
end