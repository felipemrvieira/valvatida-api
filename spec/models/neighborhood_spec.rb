require 'rails_helper' 

describe Neighborhood do 
  it "its valid with a city and name" do 
    country = Country.create(name: 'Brasil')
    state = State.create(name: 'Alagoas', country_id: country.id)
    city = City.create(name: 'Maceió', state_id: state.id)
    neighborhood = Neighborhood.new(name: 'Ponta verde', city_id: city.id) 
    expect(neighborhood).to be_valid 
  end

  it "its invalid without a name" do 
    country = Country.create(name: 'Brasil')
    state = State.create(name: 'Alagoas', country_id: country.id)
    city = City.create(name: 'Maceió', state_id: state.id)
    neighborhood = Neighborhood.new(city_id: city.id) 
    expect(neighborhood).not_to be_valid 
  end

  it "its invalid without a city" do 
    neighborhood = Neighborhood.new(name: 'Ponta verde') 
    expect(neighborhood).not_to be_valid 
  end

  it "its invalid with an used name related to a state" do 
    country = Country.create(name: 'Brasil')
    state = State.create(name: 'Alagoas', country_id: country.id)
    city = City.create(name: 'Maceió', state_id: state.id)
    neighborhood = Neighborhood.create(name: 'Ponta verde', city_id: city.id) 
    neighborhood = Neighborhood.new(name: 'Ponta verde', city_id: city.id) 
    expect(neighborhood).not_to be_valid
  end
end
