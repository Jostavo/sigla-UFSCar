class AddColumnFunctionToLaboratory < ActiveRecord::Migration[5.0]
  def change
    add_column :laboratories, :function, :string
  end
end
