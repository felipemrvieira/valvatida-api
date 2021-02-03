require 'rails_helper' 

describe CourseGroup do
  it { is_expected.to validate_presence_of(:title) }
  it { is_expected.to have_many(:courses) }
end