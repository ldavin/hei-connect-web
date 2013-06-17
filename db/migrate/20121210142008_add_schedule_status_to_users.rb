class AddScheduleStatusToUsers < ActiveRecord::Migration
  def change
    add_column :users, :schedule_state, :string
  end
end
