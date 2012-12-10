class AddScheduleStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :schedule_state, :string, default: User::SCHEDULE_STATES.first
  end
end
