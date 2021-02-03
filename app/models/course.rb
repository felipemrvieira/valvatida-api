class Course < ApplicationRecord
  belongs_to :school
  belongs_to :course_group
  has_many :subjects
  has_many :enrollments, dependent: :nullify
  has_many :students, through: :enrollments
  validates :title, presence: true
end
