class RefactorCourses < ActiveRecord::Migration
  def up
    remove_column :courses, :group
    remove_column :courses, :code
    remove_column :courses, :name
    remove_column :courses, :room
    remove_column :courses, :teacher
    remove_column :courses, :week_id
    remove_column :courses, :week_rev

    add_column :courses, :ecampus_id, :integer
    add_column :courses, :section_id, :integer
    add_column :courses, :group_id, :integer
    add_index :courses, :ecampus_id
    add_index :courses, :section_id
    add_index :courses, :group_id
  end

  def down
    add_column :courses, :group, :string
    add_column :courses, :code, :string
    add_column :courses, :name, :string
    add_column :courses, :room, :string
    add_column :courses, :teacher, :string
    add_column :courses, :week_id, :integer
    add_column :courses, :week_rev, :integer
    add_index :courses, :week_id

    remove_column :courses, :ecampus_id
    remove_column :courses, :section_id
    remove_column :courses, :group_id
  end
end
