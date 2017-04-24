class AuthorizedPerson < ApplicationRecord
  belongs_to :user
  belongs_to :laboratory

  validates :status, format: { with: /(^authorized$|^paused$|^expired$|^$)/, message: "only allow 'authorized', 'paused' or 'expired'"}, presence: true
  validates :biometric, presence: true #hash
  validates_uniqueness_of :user_id, :scope => :laboratory_id
end
