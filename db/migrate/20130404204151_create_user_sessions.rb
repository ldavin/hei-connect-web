class CreateUserSessions < ActiveRecord::Migration
  def change
    create_table :user_sessions do |t|
      t.integer :year
      t.integer :try, default: 1
      t.integer :absences_session
      t.integer :grades_session
      t.references :user

      t.timestamps
    end
  end
end
