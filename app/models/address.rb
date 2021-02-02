class Address < ApplicationRecord
  belongs_to :neighborhood
  validates :street, :number, presence: true
  has_many :students
  has_many :schools
end
