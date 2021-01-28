require 'rails_helper' 

describe State do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:country_id) }
  it { is_expected.to belong_to(:country) }
  it { is_expected.to have_many(:cities) }
end
