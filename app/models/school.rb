class School < ApplicationRecord
  belongs_to :address
  has_many :teachers
  has_many :courses
  validates :name, presence: true
end
