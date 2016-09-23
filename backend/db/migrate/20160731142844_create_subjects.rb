class CreateSubjects < ActiveRecord::Migration[5.0]
  def change
    create_table :subjects do |t|
      t.datetime :begin
      t.datetime :end
      t.string :title

      t.timestamps
    end
  end
end
