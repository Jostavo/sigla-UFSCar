class Status < ApplicationRecord
  belongs_to :laboratory

  def self.today_open_in_seconds
    self.today.count * (5*60)
  end

  def self.last_week_open_in_seconds
    self.last_week.count * (5*60)
  end

  def self.average_this_week
      (self.beginning_week.count * (5*60))/7
  end

  def self.average_last_week
    (self.last_week.count * (5*60))/7
  end

  scope :week, -> {
    where(created_at: 1.week.ago.at_beginning_of_day..DateTime.now.at_end_of_day)
  }

  scope :beginning_week, -> {
    where(created_at: DateTime.now.beginning_of_week..DateTime.now.end_of_week)
  }

  scope :last_week, -> {
    where(created_at: 1.week.ago.at_beginning_of_day..1.week.ago.at_end_of_day)
  }

  scope :today, -> {
    where(created_at: DateTime.now.at_beginning_of_day..DateTime.now.at_end_of_day)
  }

end
