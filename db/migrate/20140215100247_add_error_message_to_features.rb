class AddErrorMessageToFeatures < ActiveRecord::Migration
  def change
    add_column :features, :error_message, :string
  end
end
