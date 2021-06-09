class Address < ApplicationRecord
  belongs_to :neighborhood
  validates :street, :number, presence: true
  has_many :students
  has_many :schools

  def extra
    {
      "country": self.neighborhood.city.state.country,
      "state": self.neighborhood.city.state,
      "city": self.neighborhood.city,
      "neighborhood": self.neighborhood
    }
  end
end
