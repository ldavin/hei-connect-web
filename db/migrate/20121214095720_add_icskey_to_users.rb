class AddIcskeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :ics_key, :string
  end
end
