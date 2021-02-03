FactoryBot.define do
  factory :student do
    name { FFaker::NameBR.name }
    email { FFaker::Internet.email }
    password { '123123' }
    address
  end
end
