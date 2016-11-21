class Computer < ApplicationRecord
  belongs_to :laboratory
  validates :status, format: { with: /(^busy$|^maintenance$|^available$|^$)/, message: "only allow 'maintenance', 'busy' or 'available'"}

  has_many :computer_status
  has_many :reports

  def last_status
    puts self.status
    if(self.status == "maintenance")
      return "maintenance"
    end

    time = self.updated_at + 600
    if(Time.now > time)
      return "busy"
    end
    self.status
  end

end
