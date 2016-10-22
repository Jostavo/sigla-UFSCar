class Laboratory < ApplicationRecord
  validates :title, presence: true
  validates :mantainer, presence: true
  validates :email, presence: true
  validates :linkDocs, presence: true
  validates :initials, presence: true, uniqueness: true

  has_many :status, dependent: :destroy
  has_many :subjects, dependent: :destroy
  has_many :computers, dependent: :destroy
end
