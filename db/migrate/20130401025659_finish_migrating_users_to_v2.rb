class FinishMigratingUsersToV2 < ActiveRecord::Migration
  def up
    remove_column :users, :encrypted_plain_password
  end

  def down
    add_column :users, :encrypted_plain_password, :string
  end
end
