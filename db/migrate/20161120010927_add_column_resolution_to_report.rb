class AddColumnResolutionToReport < ActiveRecord::Migration[5.0]
  def change
    add_column :reports, :resolution, :string
  end
end
