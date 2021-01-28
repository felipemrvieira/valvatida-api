require 'rails_helper' 

describe Country do 
  # build from factory bot
  it "its valid with a name" do 
    country = build(:country)
    expect(country).to be_valid 
  end

  # shoulda matcher sintax
  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }
  it { is_expected.to have_many(:states) }

  # build and create from factory bot
  it "its invalid with an used name" do 
    country = create(:country, name: 'Brasil')
    country = build(:country, name: 'Brasil')
    expect(country).not_to be_valid 
  end
end
