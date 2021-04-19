require 'rails_helper' 

describe SchoolAdmin do
  it { is_expected.to belong_to(:admin) }
  it { is_expected.to belong_to(:school) }
end
