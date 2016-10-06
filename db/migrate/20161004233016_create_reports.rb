class CreateReports < ActiveRecord::Migration[5.0]
  def change
    create_table :reports do |t|
      t.string :title
      t.string :description
      t.string :solution

      t.timestamps
    end
  end
end
