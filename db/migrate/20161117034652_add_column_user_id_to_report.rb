class AddColumnUserIdToReport < ActiveRecord::Migration[5.0]
  def change
    add_reference :reports, :user, foreign_key: true
  end
end
