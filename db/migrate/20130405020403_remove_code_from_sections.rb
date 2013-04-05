class RemoveCodeFromSections < ActiveRecord::Migration
  def up
    remove_column :sections, :code
  end

  def down
    add_column :sections, :code, :string
  end
end
