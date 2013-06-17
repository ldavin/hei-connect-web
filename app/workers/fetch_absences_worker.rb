class FetchAbsencesWorker
  extend ApplicationWorker

  @queue = :low

  def self.update_object *args
    user = User.find(args.flatten.first)
    session = UserSession.find(args.flatten.second)

    user.absences_update(session.absences_session)
  end

  def self.perform user_id, session_id, *args
    user = User.find user_id
    session = UserSession.find session_id
    ecampus_id = session.absences_session

    user.absences_rev_increment!(ecampus_id)
    revision = user.absences_rev(ecampus_id)

    # Fetch the absences
    client = Client.new
    absences = client.absences user, session

    absences.each do |absence|
      # If the absence is not justified, we fix it
      absence.justification = nil if absence.justification == '.'

      # Retrieve the linked section
      section = Section.where(name: absence.course).first_or_create!

      # Create or retrieve the absence
      absence_db = Absence.where(user_session_id: session.id, section_id: section.id, date: absence.date,
                                 length: absence.length, excused: absence.excused,
                                 justification: absence.justification).first_or_create!

      # Silently update the revision
      absence_db.update_column :update_number, revision
    end

    # Tidy up the user's absences
    Absence.where(user_session_id: session.id).where("update_number != ?", revision).destroy_all
  end
end