class AddTypeToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :type_user, :string
  end
end
