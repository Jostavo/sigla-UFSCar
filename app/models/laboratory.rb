class Laboratory < ApplicationRecord
  validates :title, presence: true
  validates :mantainer, presence: true
  validates :email, presence: true
  validates :linkDocs, presence: true
  validates :initials, presence: true, uniqueness: true

  has_many :status, dependent: :destroy
  has_many :subjects, dependent: :destroy
  has_many :computers, dependent: :destroy
  has_many :reports, dependent: :destroy


  has_many :authorized_person
  has_many :authorized_people, :through => :authorized_person, :source => :user
end
