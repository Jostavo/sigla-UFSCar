class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:github, :facebook]
  validates :function, format: { with: /(^admin$|^technician$|^normal$|^$)/, message: "only allow 'admin', 'technician' or 'normal'"}
  validates :type_user, format: { with: /(^Graduação$|^Pós-Graduação$|^Professor$|^Técnico Administrativo$|^$)/, message: "Insira corretamente o tipo de usuário"}
  validates :name, presence: true

  has_many :authorized_person
  has_many :authorized_laboratory, :through => :authorized_person, :source => :laboratory

  has_many :reports

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
