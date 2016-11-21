class AddColumnNameToReport < ActiveRecord::Migration[5.0]
  def change
    add_column :reports, :user_name, :string
  end
end
