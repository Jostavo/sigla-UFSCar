class CreateUsersAdvisors < ActiveRecord::Migration[5.0]
  def change
    create_table :users_advisors do |t|
      t.references :professor, foreign_key: true
      t.references :student, foreign_key: true

      t.timestamps
    end
  end
end
