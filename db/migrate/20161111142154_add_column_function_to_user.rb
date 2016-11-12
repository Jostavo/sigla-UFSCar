class AddColumnFunctionToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :function, :string, :default => "normal"
  end
end
