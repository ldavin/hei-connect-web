class AddIcsLastActivityToUser < ActiveRecord::Migration
  def change
    add_column :users, :ics_last_activity, :datetime
  end
end
