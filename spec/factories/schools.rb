FactoryBot.define do
  factory :school do
    name { FFaker::Education.school_name }
    address
  end
end
