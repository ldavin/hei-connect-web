class FetchScheduleWorker
  def perform(user_id)
    user = User.find(user_id)

    if user.schedule_ok? or user.schedule_unknown? or user.schedule_failed?
      user.schedule_updating!

      begin
        client = Client.new
        weeks = client.fetch 'schedule', user, Client::ApiWeek

        user.schedule_rev_increment!
        revision = user.schedule_rev

        weeks.each do |week|
          week.courses.each do |course|
            # Only consider the courses having a date, length and name
            if course.date.present? and course.length.present? and course.name.present?

              # Parameters to find the course
              search_options = {date: course.date, length: course.length}
              if course.id.present? and course.code.present? and course.group.present? and course.type.present?
                section = Section.where(code: course.code, name: course.name).first_or_create!
                group = Group.where(name: course.group).first_or_create!

                search_options.merge! ecampus_id: course.id, kind: course.type, section_id: section.id, group_id: group.id
              else
                search_options.merge! broken_name: course.name
              end

              course_db = Course.where(search_options).first_or_create!

              # Link the course to the user, and increment the update_attribute
              touch_user = true if CourseUser.where(course_id: course_db.id, user_id: user.id).count == 0
              course_user = CourseUser.where(course_id: course_db.id, user_id: user.id).first_or_create! update_number: revision
              course_user.update_attribute :update_number, revision

              # Update the rooms
              if course.room.present?
                rooms = [Room.where(name: course.room).first_or_create!]
                course_db.rooms = rooms
              end

              # Update the teachers
              if course.teachers.present?
                teachers = Array.new
                course.teachers.each do |teacher|
                  teachers.push Teacher.where(name: teacher).first_or_create!
                end
                course_db.teachers = teachers
              end
            end
          end
        end

        # Tidy up the user's courses list, a cron task will take care of the rest
        CourseUser.where(user_id: user.id).where("update_number != ?", revision).delete_all

        # Done updating! It will also touch the user to refresh caches
        user.schedule_ok!

      rescue
        user.schedule_failed!
      end
    end
  end

  handle_asynchronously :perform, :queue => 'updates'
end