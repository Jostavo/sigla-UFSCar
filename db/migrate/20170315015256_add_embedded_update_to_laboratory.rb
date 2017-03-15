class AddEmbeddedUpdateToLaboratory < ActiveRecord::Migration[5.0]
  def change
    add_column :laboratories, :embedded_update, :boolean
  end
end
