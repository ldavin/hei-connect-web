class CreateAbsences < ActiveRecord::Migration
  def change
    create_table :absences do |t|
      t.datetime :date
      t.integer :length
      t.boolean :excused
      t.string :justification
      t.integer :update_number
      t.references :section
      t.references :user_session

      t.timestamps
    end
    add_index :absences, :section_id
    add_index :absences, :user_session_id
  end
end
