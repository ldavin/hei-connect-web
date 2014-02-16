class AddApiTokenAndApiLastActivityToUsers < ActiveRecord::Migration
  def change
    add_column :users, :api_token, :string
    add_column :users, :api_last_activity, :datetime
  end
end
