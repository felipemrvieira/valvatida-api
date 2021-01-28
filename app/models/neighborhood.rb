class Neighborhood < ApplicationRecord
  belongs_to :city
  has_many :addresses
  validates :name, presence: true
  validates_uniqueness_of :name, scope: :city_id
end
