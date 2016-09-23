class AddLaboratoryReferencesToSubject < ActiveRecord::Migration[5.0]
  def change
    add_reference :subjects, :laboratory, foreign_key: true
  end
end
