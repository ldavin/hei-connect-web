class CreateCourseTeachers < ActiveRecord::Migration
  def change
    create_table :course_teachers do |t|
      t.references :course
      t.references :teacher
    end
    add_index :course_teachers, :course_id
    add_index :course_teachers, :teacher_id
  end
end
