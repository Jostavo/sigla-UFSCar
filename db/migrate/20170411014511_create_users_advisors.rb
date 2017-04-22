class CreateUsersAdvisors < ActiveRecord::Migration[5.0]
  def change
    create_table :users_advisors do |t|
      t.references :user, :professor
      t.references :user, :student
      t.timestamps
    end
  end
end
