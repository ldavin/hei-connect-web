class CleanCourses < ActiveRecord::Migration
  def up
    Course.destroy_all
  end

  def down
  end
end
