class Biometric < ApplicationRecord
  validates :hash_biometric, presence: true

end
