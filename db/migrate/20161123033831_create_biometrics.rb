class CreateBiometrics < ActiveRecord::Migration[5.0]
  def change
    create_table :biometrics do |t|
      t.string :hash_biometric

      t.timestamps
    end
  end
end
