class AddRevisionNumberToWeeks < ActiveRecord::Migration
  def change
    add_column :weeks, :rev, :integer
  end
end
