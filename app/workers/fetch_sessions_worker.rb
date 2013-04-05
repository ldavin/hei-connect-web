class FetchSessionsWorker
  def perform(user_id)
    user = User.find user_id

    if user.sessions_ok? or user.sessions_unknown? or user.sessions_failed?
      user.sessions_updating!

      begin
        client = Client.new

        user.sessions_rev_increment!
        revision = user.sessions_rev

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

        user.sessions_ok!
      rescue
        user.sessions_failed!
      end
    end
  end

  handle_asynchronously :perform, :queue => 'updates', :priority => 50
end