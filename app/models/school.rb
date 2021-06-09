class School < ApplicationRecord
  belongs_to :address
  has_many :teachers
  has_many :courses
  validates :name, presence: true
  
  after_create :create_tenant

  def create_tenant
    Apartment::Tenant.create(subdomain)
  end
end
