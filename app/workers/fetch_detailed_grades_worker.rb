class FetchDetailedGradesWorker < ApplicationWorker

  def initialize(user_id, session_id)
    @user_id = user_id
    @session_id = session_id

    user = User.find @user_id
    session = UserSession.find @session_id
    super user.grades_update(session.grades_session).id, 'update_grades'
  end

  def perform
    if Feature.update_grades_enabled?
      user = User.find @user_id
      session = UserSession.find @session_id
      ecampus_id = session.grades_session

      user.grades_rev_increment!(ecampus_id)
      revision = user.grades_rev(ecampus_id)

      # Fetch the grades to count them
      client = Client.new
      grades = client.detailed_grades user, session
      exams = Array.new

      grades.each do |grade|
        # Retrieve the linked section
        section = Section.where(name: grade.course).first_or_create!

        # Create or retrieve the exam
        exam_db = Exam.where(section_id: section.id, name: grade.name, date: grade.date,
                             kind: grade.type.capitalize, weight: grade.weight).first_or_create!

        # Create or retrieve the grade (link to the exam)
        grade_db = Grade.where(user_session_id: session.id, mark: grade.mark,
                               unknown: grade.unknown, exam_id: exam_db.id).first_or_create!

        # Silently update the revision
        grade_db.update_column :update_number, revision

        # Keep track of the exam
        exams.push exam_db
      end

      # Tidy up the user's grades
      Grade.where(user_session_id: session.id).where("update_number != ?", revision).destroy_all

      # Eventually update the exams average
      exams.each do |exam|
        exam.update_average_and_counter
      end
    end
  end
end