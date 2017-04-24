class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:github, :facebook]
  validates :function, format: { with: /(^admin$|^technician$|^normal$|^$)/, message: "only allow 'admin', 'technician' or 'normal'"}
  validates :type_user, format: { with: /(^graduation$|^postgraduate$|^professor$|^administrative technician$|^$)/, message: "Insira corretamente o tipo de usuário"}
  validates :name, presence: true

  has_many :authorized_person
  has_many :authorized_laboratory, :through => :authorized_person, :source => :laboratory

  has_many :reports

  # user's advisor
  has_many :passive_relationship, class_name: "UsersAdvisor",
                                  foreign_key: "student_id"
  has_many :active_relationship , class_name: "UsersAdvisor",
                                  foreign_key: "professor_id"

  has_many :students, :through => :active_relationship,
                       source: :student
  has_many :professor, :through => :passive_relationship,
                       source: :professor
  accepts_nested_attributes_for :passive_relationship
  accepts_nested_attributes_for :active_relationship

  def isAdmin?
    self.function == "admin"
  end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      user.name = auth.info.name
    end
  end
end
