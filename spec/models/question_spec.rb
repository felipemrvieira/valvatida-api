require 'rails_helper' 

describe Question do
  it { is_expected.to validate_presence_of(:label) }
  it { is_expected.to validate_presence_of(:command) }
  it { is_expected.to belong_to(:subject) }
  it { is_expected.to belong_to(:teacher) }
end
