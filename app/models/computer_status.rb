class ComputerStatus < ApplicationRecord
  belongs_to :computer

  validates :status, format: { with: /(^busy$|^maintenance$|^available$|^$)/, message: "only allow 'maintenance', 'busy' or 'available'"}

  def is_available?
    time = Time.now
    if self.status == "available"
      puts time
      if(time.hour <= self.created_at.hour + 600)
        return true
      end
    end

    false
  end

  def last_status
    time = self.created_at + 600
    if(Time.now.hour > time.hour)
      return "pc"
    end
    self.status
  end
end
