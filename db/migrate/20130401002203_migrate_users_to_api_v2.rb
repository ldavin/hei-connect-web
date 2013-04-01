class MigrateUsersToApiV2 < ActiveRecord::Migration
  def up
    say "Removing old columns."
    remove_column :users, :ecampus_user_id
    remove_column :users, :ecampus_student_id

    say "Adding new columns."
    add_column :users, :password_digest, :string
    add_column :users, :token, :string
    rename_column :users, :encrypted_password, :encrypted_plain_password
  end

  def down
    add_column :users, :ecampus_user_id, :integer
    add_column :users, :ecampus_student_id, :integer
    rename_column :users, :encrypted_plain_password, :encrypted_password

    remove_column :users, :password_digest
    remove_column :users, :token
  end
end
