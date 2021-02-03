require 'rails_helper' 

describe School do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to belong_to(:address) }
  it { is_expected.to have_many(:teachers) }
  it { is_expected.to have_many(:courses) }
end
