FactoryBot.define do
  factory :course_group do
    title { FFaker::Education.major }
  end
end
