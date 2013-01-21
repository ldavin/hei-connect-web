class CleanDatabaseAfterApiRefactor < ActiveRecord::Migration
  def up
    say "Deleting unverified users."
    User.unverified.each do |user|
      user.destroy
    end

    say "Changing schedule_planned statuses to ok."
    User.schedule_planned.each do |user|
      user.schedule_ok!
    end
  end

  def down
  end
end
