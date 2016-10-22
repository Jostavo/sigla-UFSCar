class Subject < ApplicationRecord
  validates :begin_time, presence: true
  validates :end_time, presence: true
  validates :title, presence: true

  belongs_to :laboratory

  scope :today, -> {
    where(begin_time: DateTime.now.at_beginning_of_day..DateTime.now.at_end_of_day)
  }
end
