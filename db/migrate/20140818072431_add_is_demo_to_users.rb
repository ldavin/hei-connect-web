class AddIsDemoToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_demo, :boolean, default: false
  end
end
