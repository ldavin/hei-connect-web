class CreateCourseUsers < ActiveRecord::Migration
  def change
    create_table :course_users do |t|
      t.integer :update_number
      t.references :course
      t.references :user

      t.timestamps
    end
    add_index :course_users, :course_id
    add_index :course_users, :user_id
  end
end
