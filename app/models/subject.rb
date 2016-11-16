class Subject < ApplicationRecord
  validates :begin_time, presence: true
  validates :end_time, presence: true
  validates :title, presence: true

  belongs_to :laboratory

  scope :today, -> {
    where(begin_time: DateTime.now.at_beginning_of_day..DateTime.now.at_end_of_day)
  }

  def self.today_with_hash
    days = Hash.new
    (0..23).each do |n|
      days[:"#{n}"] = "Vazio"
    end

    a = self.today
    a.each do |hour|
      days[:"#{hour.begin_time.hour}"] = hour.title
    end

    puts days
    days
  end
end
