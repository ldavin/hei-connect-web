class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.string :name
      t.date :date
      t.string :kind
      t.float :weight
      t.float :average
      t.integer :grades_count
      t.references :section

      t.timestamps
    end
    add_index :exams, :section_id
  end
end
