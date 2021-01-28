require 'rails_helper' 

describe Neighborhood do 
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name).scoped_to(:city_id) }
  it { is_expected.to belong_to(:city) }
  it { is_expected.to have_many(:addresses) }  
end
