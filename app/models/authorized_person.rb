class AuthorizedPerson < ApplicationRecord
  belongs_to :user
  belongs_to :laboratory

  validates :biometric, presence: true
end
