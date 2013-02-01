class CreateUpdates < ActiveRecord::Migration
  def change
    create_table :updates do |t|
      t.string :object
      t.string :state
      t.integer :rev, default: 0
      t.references :user

      t.timestamps
    end
    add_index :updates, :user_id
  end
end
