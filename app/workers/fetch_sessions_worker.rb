class FetchSessionsWorker
  def perform(user_id)
    user = User.find user_id

    if user.sessions_ok? or user.sessions_unknown? or user.sessions_failed?
      user.sessions_updating!

      begin
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

            # Raise an exception if the year is still nil
            raise Exception if year.nil?

            # Fetch the right corresponding user session
            user_session = UserSession.where(user_id: user.id, year: year).first_or_create!
            if user_session.send("#{type}_session").present? and user_session.send("#{type}_session") != session.id
              user_session = UserSession.where(user_id: user.id, year: year, try: 2).first_or_create!
            end

            # Update the session id and save entity
            user_session.send "#{type}_session=", session.id
            user_session.save
          end
        end

        user.sessions_ok!
      rescue
        user.sessions_failed!
      end
    end
  end

  handle_asynchronously :perform, :queue => 'updates'
end