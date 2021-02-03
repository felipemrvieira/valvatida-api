FactoryBot.define do
  factory :course_group do
    title { Faker::Education.major }
  end
end
