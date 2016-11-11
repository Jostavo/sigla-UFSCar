class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :function, format: { with: /(^admin$|^technician$|^normal$|^$)/, message: "only allow 'admin', 'technician' or 'normal'"}
  validates :name, presence: true

  def isAdmin?
    self.function == "admin"
  end
end
