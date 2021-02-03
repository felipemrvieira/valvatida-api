require 'rails_helper' 

describe Student do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to belong_to(:address) }
  it { is_expected.to have_many(:enrollments) }
  it { is_expected.to have_many(:courses) }
end