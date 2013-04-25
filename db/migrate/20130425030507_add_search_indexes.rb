class AddSearchIndexes < ActiveRecord::Migration
  def change
    add_index :updates, [:user_id, :object]
    add_index :sections, :name
    add_index :groups, :name
    add_index :rooms, :name
    add_index :teachers, :name
    add_index :users, :ics_key
  end
end
