class CreateCourseRooms < ActiveRecord::Migration
  def change
    create_table :course_rooms do |t|
      t.references :course
      t.references :room
    end
    add_index :course_rooms, :course_id
    add_index :course_rooms, :room_id
  end
end
