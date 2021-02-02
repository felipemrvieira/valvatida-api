class Address < ApplicationRecord
  belongs_to :neighborhood
  validates :street, :number, presence: true
end
