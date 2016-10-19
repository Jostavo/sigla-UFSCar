class Laboratory < ApplicationRecord
  validates :title, presence: true
  validates :mantainer, presence: true
  validates :email, presence: true
  validates :linkDocs, presence: true
  validates :initials, presence: true

  has_many :status
  has_many :subjects
end
