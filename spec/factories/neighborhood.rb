FactoryBot.define do
  factory :neighborhood do
    name { FFaker::AddressBR.neighborhood}
    city
  end
end