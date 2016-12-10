class CreateBiometricAccesses < ActiveRecord::Migration[5.0]
  def change
    create_table :biometric_accesses do |t|
      t.references :laboratory, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
