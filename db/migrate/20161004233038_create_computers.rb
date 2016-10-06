class CreateComputers < ActiveRecord::Migration[5.0]
  def change
    create_table :computers do |t|
      t.references :laboratory, foreign_key: true

      t.timestamps
    end
  end
end
