class AddPhysicalIdToComputer < ActiveRecord::Migration[5.0]
  def change
    add_column :computers, :physical_id, :integer
  end
end
