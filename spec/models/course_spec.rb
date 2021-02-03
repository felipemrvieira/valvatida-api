require 'rails_helper' 

describe Course do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to belong_to(:school) }
  it { is_expected.to belong_to(:course_group).optional }
  it { is_expected.to have_many(:subjects) }
  it { is_expected.to have_many(:enrollments) }
  it { is_expected.to have_many(:students) }
end