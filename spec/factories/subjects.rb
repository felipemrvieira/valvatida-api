FactoryBot.define do
  factory :subject do
    title { FFaker::Education.degree_short }
    course
  end
end
