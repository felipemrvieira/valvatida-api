class Address < ApplicationRecord
  belongs_to :neighborhood
  validates :public_place, :number, presence: true
end
