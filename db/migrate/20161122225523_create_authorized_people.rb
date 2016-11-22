class CreateAuthorizedPeople < ActiveRecord::Migration[5.0]
  def change
    create_table :authorized_people do |t|
      t.references :user, foreign_key: true
      t.references :laboratory, foreign_key: true
      t.string :biometric

      t.timestamps
    end
  end
end
