FactoryBot.define do
  factory :address do
    street { FFaker::AddressBR.street }
    number { FFaker::AddressBR.building_number }
    lat { "-9.658250" }
    long { "-35.701325" }
    neighborhood
  end
end