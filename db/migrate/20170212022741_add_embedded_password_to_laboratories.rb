class AddEmbeddedPasswordToLaboratories < ActiveRecord::Migration[5.0]
  def change
    add_column :laboratories, :password, :string
  end
end
