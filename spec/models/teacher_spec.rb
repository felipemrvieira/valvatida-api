require 'rails_helper' 

describe Teacher do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to belong_to(:school) }
  it { is_expected.to have_many(:questions) }
end
