class AddMissingIndexToUserSessions < ActiveRecord::Migration
  def change
    add_index :user_sessions, :user_id
  end
end