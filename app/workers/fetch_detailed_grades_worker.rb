class FetchDetailedGradesWorker
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

      user.grades_rev_increment!(ecampus_id)
      revision = user.grades_rev(ecampus_id)

      # Fetch the grades to count them
      grades = client.detailed_grades user, session

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
      end

      # Tidy up the user's grades
      Grade.where(user_session_id: session.id).where("update_number != ?", revision).destroy_all

      user.grades_ok!(ecampus_id)
    rescue
      user.grades_failed!(ecampus_id)
    end
  end

  handle_asynchronously :perform, :queue => 'updates', :priority => 100
end