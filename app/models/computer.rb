class Computer < ApplicationRecord
  belongs_to :laboratory

  has_many :computer_status
end
