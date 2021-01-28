require 'rails_helper'

describe Address, type: :model do
  it "its valid with a neighborhood, public place and number" do 
    country = Country.create(name: 'Brasil')
    state = State.create(name: 'Alagoas', country_id: country.id)
    city = City.create(name: 'Maceió', state_id: state.id)
    neighborhood = Neighborhood.create(name: 'Ponta verde', city_id: city.id)
    address = Address.new(public_place: 'Rua Carlos Tenório', number: '32', neighborhood_id: neighborhood.id)
    expect(address).to be_valid 
  end

  it "its invalid without a public place" do 
    country = Country.create(name: 'Brasil')
    state = State.create(name: 'Alagoas', country_id: country.id)
    city = City.create(name: 'Maceió', state_id: state.id)
    neighborhood = Neighborhood.create(name: 'Ponta verde', city_id: city.id)
    address = Address.new(number: '32', neighborhood_id: neighborhood.id)
    expect(address).not_to be_valid 
  end

  it "its invalid without a number" do 
    country = Country.create(name: 'Brasil')
    state = State.create(name: 'Alagoas', country_id: country.id)
    city = City.create(name: 'Maceió', state_id: state.id)
    neighborhood = Neighborhood.create(name: 'Ponta verde', city_id: city.id)
    address = Address.new(public_place: 'Rua Carlos Tenório', neighborhood_id: neighborhood.id)
    expect(address).not_to be_valid 
  end

  it "its invalid without a neighborhood" do 
    address = Address.new(public_place: 'Rua Carlos Tenório', number: '32')
    expect(address).not_to be_valid 
  end
end
