class Laboratory < ApplicationRecord
  validates :title, presence: true
  validates :mantainer, presence: true
  validates :email, presence: true
  validates :initials, presence: true, uniqueness: true
  validates :embedded_password, uniqueness: true, presence: true

  has_many :status, dependent: :destroy
  has_many :subjects, dependent: :destroy
  has_many :computers, dependent: :destroy
  has_many :reports, dependent: :destroy


  # authorized person to access the laboratory
  has_many :authorized_person
  has_many :authorized_people, :through => :authorized_person, :source => :user

  # access's history
  has_many :biometric_access
  has_many :access_people, :through => :biometric_access, :source => :user
end
