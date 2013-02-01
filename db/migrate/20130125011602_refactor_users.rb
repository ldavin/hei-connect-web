class RefactorUsers < ActiveRecord::Migration
  def up
    say "Removing old columns."
    remove_column :users, :state
    remove_column :users, :schedule_state

    say "Adding new columns and indexes."
    add_column :users, :ecampus_user_id, :integer
    add_column :users, :ecampus_student_id, :integer

    add_index :users, :ecampus_id
  end

  def down
    add_column :users, :state, :string
    add_column :users, :schedule_state, :string

    remove_column :users, :ecampus_user_id
    remove_column :users, :ecampus_student_id
  end
end
