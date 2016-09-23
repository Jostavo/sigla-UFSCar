class AddInitialsToLaboratory < ActiveRecord::Migration[5.0]
  def change
    add_column :laboratories, :initials, :string
  end
end
