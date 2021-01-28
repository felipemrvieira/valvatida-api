require 'rails_helper' 

describe Country do 
  it "its valid with a name" do 
    country = Country.new(name: 'Brasil') 
    expect(country).to be_valid 
  end

  it "its invalid without a name" do 
    country = Country.new() 
    expect(country).not_to be_valid 
  end

  it "its invalid with an used name" do 
    country = Country.create(name: 'Brasil') 
    country = Country.new(name: 'Brasil') 
    expect(country).not_to be_valid 
  end
end
