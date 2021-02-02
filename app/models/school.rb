class School < ApplicationRecord
  belongs_to :address
  has_many :teachers
  has_many :courses
end
