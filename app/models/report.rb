class Report < ApplicationRecord
  belongs_to :computer
  belongs_to :user
  belongs_to :laboratory

  validates :resolution, format: { with: /(^pending$|^verifying$|^resolved$|^$)/, message: "only allow 'pending', 'verifyng' or 'resolved'"}
end
