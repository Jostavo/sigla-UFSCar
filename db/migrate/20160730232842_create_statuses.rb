class CreateStatuses < ActiveRecord::Migration[5.0]
  def change
    create_table :statuses do |t|
      t.references :laboratory, foreign_key: true
      t.boolean :isOpen

      t.timestamps
    end
  end
end
