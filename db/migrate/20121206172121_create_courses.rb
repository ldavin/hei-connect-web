class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.datetime :date
      t.integer :length
      t.string :type
      t.string :group
      t.string :code
      t.string :name
      t.string :room
      t.string :teacher
      t.references :week

      t.timestamps
    end
    add_index :courses, :week_id
  end
end
