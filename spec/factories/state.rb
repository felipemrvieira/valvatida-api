FactoryBot.define do
  factory :state do
    name { FFaker::AddressBR.state}
    country
  end
end