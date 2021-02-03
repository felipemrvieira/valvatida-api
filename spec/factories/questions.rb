FactoryBot.define do
  factory :question do
    label { FFaker::LoremIE.sentence }
    command { FFaker::LoremIE.question }
    subject
    teacher
  end
end
