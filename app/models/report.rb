class Report < ApplicationRecord
  belongs_to :computer
  belongs_to :user
  belongs_to :laboratory
end
