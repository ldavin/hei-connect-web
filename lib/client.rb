class Client < RocketPants::Client

  class ApiUser < APISmith::Smash
    property :username
    property :token
  end

  class ApiTeacher < APISmith::Smash
    property :name
  end

  class ApiCourse < APISmith::Smash
    property :id
    property :date, transformer: lambda { |d| Time.zone.parse d }
    property :length
    property :type
    property :group
    property :code
    property :name
    property :room
    property :teachers, tranformer: Client::ApiTeacher
  end

  class ApiWeek < APISmith::Smash
    property :number
    property :courses, transformer: Client::ApiCourse
  end

  class ApiSession < APISmith::Smash
    property :id
    property :name
  end

  class ApiGrade < APISmith::Smash
    property :program
    property :course
    property :semester
    property :type
    property :mark
  end

  class ApiGradeDetailed < APISmith::Smash
    property :program
    property :course
    property :name
    property :date
    property :type
    property :weight
    property :mark
    property :unknown
  end

  class ApiAbsence < APISmith::Smash
    property :date, transformer: lambda { |d| Time.zone.parse d }
    property :length
    property :course
    property :excused
    property :justification
  end

  version 2
  base_uri HEI_CONNECT['base']

  def user(username, password)
    get 'users', extra_query: {user: {username: username, password: password}}, transformer: ApiUser
  end

  def new_user(username, password)
    post 'users', extra_query: {user: {username: username, password: password}}, transformer: ApiUser
  end

  def schedule(user)
    get "schedules/#{user.token}", transformer: ApiWeek
  end

  def absences_sessions(user)
    get "sessions/#{user.token}/absences", transformer: ApiSession
  end

  def grades_sessions(user)
    get "sessions/#{user.token}/grades", transformer: ApiSession
  end

  def grades(user, session)
    get "grades/#{user.token}", extra_query: {session_id: session.grades_session}, transformer: ApiGrade
  end

  def detailed_grades(user, session)
    get "grades/#{user.token}/detailed", extra_query: {session_id: session.grades_session}, transformer: ApiGradeDetailed
  end

  def absences(user, session)
    get "absences/#{user.token}", extra_query: {session_id: session.absences_session}, transformer: ApiAbsence
  end
end