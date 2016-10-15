class ChangeColumnInSubject < ActiveRecord::Migration[5.0]
  def change
    rename_column :subjects, :begin, :begin_time
    rename_column :subjects, :end, :end_time
  end
end
