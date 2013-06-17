class RenameLoginCheckedToStateForUsers < ActiveRecord::Migration
  def up
    add_column :users, :state, :string
    remove_column :users, :login_checked
  end

  def down
    remove_column :users, :state
    add_column :users, :login_checked, :boolean, default: false
  end
end
