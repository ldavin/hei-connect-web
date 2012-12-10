class AddWeekRevisionNumberToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :week_rev, :integer
  end
end
