require 'rails_helper' 

describe CourseGroup do
  it { is_expected.to have_many(:courses) }
end