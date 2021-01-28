require 'rails_helper' 

describe City do 
  it "its valid with a state and name" do 
    country = Country.create(name: 'Brasil')
    state = State.create(name: 'Alagoas', country_id: country.id)
    city = City.new(name: 'Maceió', state_id: state.id) 
    expect(city).to be_valid 
  end

  it "its invalid without a name" do 
    country = Country.create(name: 'Brasil')
    state = State.create(name: 'Alagoas', country_id: country.id)
    city = City.new(state_id: state.id) 
    expect(city).not_to be_valid 
  end

  it "its invalid without a state" do 
    city = City.new(name: 'Maceió') 
    expect(city).not_to be_valid 
  end

  it "its invalid with an used name related to a state" do 
    country = Country.create(name: 'Brasil')
    state = State.create(name: 'Alagoas', country_id: country.id)
    city = City.create(name: 'Maceió', state_id: state.id)
    city = City.new(name: 'Maceió', state_id: state.id) 
    expect(city).not_to be_valid
  end
end
