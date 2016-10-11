class AddComputerReferencesToReport < ActiveRecord::Migration[5.0]
  def change
    add_reference :reports, :computer, foreign_key: true
  end
end
