class AuthorizedPerson < ApplicationRecord
  belongs_to :user
  belongs_to :laboratory

  validates :biometric, presence: true
  validates_uniqueness_of :user_id, :scope => :laboratory_id
end
