class CreateGrades < ActiveRecord::Migration
  def change
    create_table :grades do |t|
      t.string :name
      t.date :date
      t.string :kind
      t.float :weight
      t.float :mark
      t.boolean :unknown
      t.integer :update_number
      t.references :user_session
      t.references :section

      t.timestamps
    end
    add_index :grades, :user_session_id
    add_index :grades, :section_id
  end
end
