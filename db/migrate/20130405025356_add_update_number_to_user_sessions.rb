class AddUpdateNumberToUserSessions < ActiveRecord::Migration
  def change
    add_column :user_sessions, :update_number, :integer
  end
end
