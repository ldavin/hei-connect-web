class AddLoginCheckToUsers < ActiveRecord::Migration
  def change
    add_column :users, :login_checked, :boolean, default: false
  end
end
