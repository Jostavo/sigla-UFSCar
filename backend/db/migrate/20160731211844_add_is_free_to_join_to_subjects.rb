class AddIsFreeToJoinToSubjects < ActiveRecord::Migration[5.0]
  def change
    add_column :subjects, :isFreeToJoin, :boolean
  end
end
