require 'rails_helper' 

describe Enrollment do
  it { is_expected.to belong_to(:course) }
  it { is_expected.to belong_to(:student) }
end