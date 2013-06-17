class FetchSessionsWorker
  extend ApplicationWorker

  @queue = :high

  def self.update_object *args
    User.find(args.flatten.first).sessions_update
  end

  def self.perform user_id, immediate = false, *args
    user = User.find user_id

    user.sessions_rev_increment!
    revision = user.sessions_rev
    client = Client.new

    %w(grades absences).each do |type|
      # Fetch the sessions and sort them (1st year to last)
      sessions = client.send "#{type}_sessions", user
      sessions.sort! { |x, y| x.id > y.id ? 1 : -1 }

      sessions.each do |session|
        # Set the year of the current session
        year = nil
        (1..5).each do |i|
          year = i if session.name.include? "#{i}A"
        end

        # We don't know how to process this session!
        next if year.nil?

        # Fetch the right corresponding user session
        user_session = UserSession.where(user_id: user.id, year: year).first_or_create!
        if user_session.send("#{type}_session").present? and user_session.send("#{type}_session") != session.id
          user_session = UserSession.where(user_id: user.id, year: year, try: 2).first_or_create!
        end

        # Update the session id and save entity
        user_session.send "#{type}_session=", session.id
        user_session.save

        # Update the revision number without touching the updated_at
        user_session.update_column :update_number, revision
      end
    end

    # Tidy up the user's sessions
    UserSession.where(user_id: user.id).where("update_number != ?", revision).delete_all

    # Schedule the grades and absences updates if asked
    # We sort the session in desc chronological order to have the interesting grades and absences first
    if immediate
      user.sessions.sort { |x, y| y.year <=> x.year }.each do |session|
        Resque.enqueue FetchDetailedGradesWorker, user.id, session.id
        Resque.enqueue FetchAbsencesWorker, user.id, session.id
      end
    end
  end
end