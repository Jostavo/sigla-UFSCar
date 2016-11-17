class AddColumnLaboratoryInitialsToReport < ActiveRecord::Migration[5.0]
  def change
    add_column :reports, :laboratory_initials, :string
  end
end
