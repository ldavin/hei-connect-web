class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.integer :number
      t.references :user

      t.timestamps
    end
    add_index :weeks, :user_id
  end
end
