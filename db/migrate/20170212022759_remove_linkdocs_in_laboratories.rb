class RemoveLinkdocsInLaboratories < ActiveRecord::Migration[5.0]
  def change
    remove_column :laboratories, :linkDocs, :string
  end
end
