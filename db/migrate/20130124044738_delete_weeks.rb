class DeleteWeeks < ActiveRecord::Migration
  def up
    drop_table :weeks
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
