class Subject < ApplicationRecord
  validates :begin_time, presence: true
  validates :end_time, presence: true
  validates :title, presence: true

  belongs_to :laboratory
end
