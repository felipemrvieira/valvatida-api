class City < ApplicationRecord
  belongs_to :state
  validates :name, presence: true
  validates_uniqueness_of :name, scope: :state_id
end
