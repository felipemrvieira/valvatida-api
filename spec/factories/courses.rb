FactoryBot.define do
  factory :course do
    name { FFaker::Education.major }
    school
    course_group
  end
end
