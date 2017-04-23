class AddStatusToAuthorizedPerson < ActiveRecord::Migration[5.0]
  def change
    add_column :authorized_people, :status, :string
  end
end
