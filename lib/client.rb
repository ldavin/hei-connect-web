class Client < RocketPants::Client

  class ApiUser < APISmith::Smash
    property :id
    property :user_id
    property :student_id
  end

  class ApiTeacher < APISmith::Smash
    property :name
  end

  class ApiCourse < APISmith::Smash
    property :id
    property :date, transformer: lambda { |d| DateTime.parse d }
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

  class ApiAbsence < APISmith::Smash
    property :date, transformer: lambda { |d| DateTime.parse d }
    property :length
    property :course
    property :excused
    property :justification
  end

  version 1
  if Rails.env.development?
    base_uri HEI_CONNECT['staging']
  else
    base_uri HEI_CONNECT['base']
  end

  def fetch(action, options, transformer)
    if options.is_a? User
      options = {
          username: options.ecampus_id,
          password: options.password,
          student_id: nil,
          user_id: nil
      }
    end
    get action, extra_query: options, transformer: transformer
  end
end