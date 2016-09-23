class CreateLaboratories < ActiveRecord::Migration[5.0]
  def change
    create_table :laboratories do |t|
      t.string :title
      t.string :mantainer
      t.string :email
      t.string :linkDocs

      t.timestamps
    end
  end
end
