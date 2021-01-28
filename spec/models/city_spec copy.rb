require 'rails_helper' 

describe City do
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:state_id) }
  it { is_expected.to belong_to(:state) }
  it { is_expected.to have_many(:neighborhoods) }
end
