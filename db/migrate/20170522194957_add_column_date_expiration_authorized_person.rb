class AddColumnDateExpirationAuthorizedPerson < ActiveRecord::Migration[5.0]
  def change
    add_column :authorized_people, :expired_at, :date
  end
end
