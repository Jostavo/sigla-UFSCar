class CreateUsersAdvisors < ActiveRecord::Migration[5.0]
  def change
    create_table :users_advisors do |t|
      t.references :professor, foreign_key: true, class_name: "User"
      t.references :student, foreign_key: true, class_name: "User"
      t.timestamps
    end
  end
end
