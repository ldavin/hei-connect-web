class AddBrokenNameToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :broken_name, :string
  end
end
