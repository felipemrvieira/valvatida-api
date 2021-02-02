FactoryBot.define do
  factory :city do
    name { FFaker::AddressBR.city}
    state
  end
end