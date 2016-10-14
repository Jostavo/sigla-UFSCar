class ComputerStatus < ApplicationRecord
  belongs_to :computer

  validates :status, format: { with: /(^busy$|^maintenance$|^available$|^$)/, message: "only allow 'maintenance', 'busy' or 'available'"}
end
