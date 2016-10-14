class AddColumnStatusToComputer < ActiveRecord::Migration[5.0]
  def change
    add_column :computers, :status, :string
  end
end
