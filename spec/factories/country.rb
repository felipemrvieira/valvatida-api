FactoryBot.use_parent_strategy

FactoryBot.define do
  factory :country do
    name {FFaker::Education.major}
  end
end