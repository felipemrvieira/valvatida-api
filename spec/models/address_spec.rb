require 'rails_helper'

describe Address, type: :model do
  it { is_expected.to validate_presence_of(:public_place) }
  it { is_expected.to validate_presence_of(:number) }
  it { is_expected.to belong_to(:neighborhood) }
end
