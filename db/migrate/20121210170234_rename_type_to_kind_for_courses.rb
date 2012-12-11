class RenameTypeToKindForCourses < ActiveRecord::Migration
  def change
    rename_column :courses, :type, :kind
  end
end
