class State < ApplicationRecord
  belongs_to :country
  has_many :cities
  validates :name, presence: true
  validates_uniqueness_of :name, scope: :country_id
end
