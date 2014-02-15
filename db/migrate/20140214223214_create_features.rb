class CreateFeatures < ActiveRecord::Migration
  def change
    create_table :features do |t|
      t.string :key
      t.boolean :enabled, default: false

      t.timestamps
    end
  end
end
