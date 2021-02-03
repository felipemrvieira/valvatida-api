FactoryBot.define do
  factory :course do
    title { FFaker::Education.major }
    school
    course_group
  end
end
