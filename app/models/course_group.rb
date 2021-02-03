class CourseGroup < ApplicationRecord
  has_many :courses
  validates :title, presence: true
end
