class AddColumnLaboratoryIdToReport < ActiveRecord::Migration[5.0]
  def change
    add_reference :reports, :laboratory, foreign_key: true
  end
end
