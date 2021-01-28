require 'rails_helper' 

describe State do 
  it "its valid with a country and name" do 
    country = Country.create(name: 'Brasil')
    state = State.new(name: 'Alagoas', country_id: country.id) 
    expect(state).to be_valid 
  end

  it "its invalid without a name" do
    country = Country.create(name: 'Brasil')
    state = State.new(country_id: country.id) 
    expect(state).not_to be_valid 
  end

  it "its invalid without a country" do 
    state = State.new(name: 'Alagoas') 
    expect(state).not_to be_valid 
  end

  it "its invalid with an used name related to a country" do 
    country = Country.create(name: 'Brasil')
    state = State.create(name: 'Alagoas', country_id: country.id)
    state = State.new(name: 'Alagoas', country_id: country.id) 
    expect(state).not_to be_valid
  end
end
