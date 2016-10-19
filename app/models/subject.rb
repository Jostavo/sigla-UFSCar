class Subject < ApplicationRecord
  validates :begin, presence: true
  validates :end, presence: true
  validates :title, presence: true

  belongs_to :laboratory
end
