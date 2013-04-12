class RethinkGrades < ActiveRecord::Migration
  def up
    remove_columns :grades, :name, :date, :kind, :weight, :section_id
    add_column :grades, :exam_id, :integer

    add_index :grades, :exam_id
  end

  def down
    remove_column :grades, :exam_id
    add_column :grades, :name, :string
    add_column :grades, :date, :date
    add_column :grades, :kind, :string
    add_column :grades, :weight, :float
    add_column :grades, :section_id, :integer
  end
end
