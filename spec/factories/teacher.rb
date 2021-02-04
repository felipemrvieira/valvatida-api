FactoryBot.define do
  factory :teacher do
    name { FFaker::NameBR.name }
    email { FFaker::Internet.email }
    password { '123123' }
    password_confirmation { '123123' }
    school
  end
end
