require 'rails_helper'

RSpec.describe "/cities", type: :request do

  let(:valid_attributes) {
    {name: "Maceió"}
  }

  let(:invalid_attributes) {
    {name: nil}
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    
    let!(:city) { create :city }
    
    before do
      get '/api/v1/cities', headers: valid_headers, as: :json
    end

    it "renders a successful response" do
      expect(response).to be_successful
    end

    it "JSON body response contains expected city attributes" do
      expect(response.body).to include_json([
        name: city.name
      ])
    end
  end

  describe "POST /create" do
    context "with valid parameters" do

      let!(:country) { create :country }
      let!(:state) { create :state, country_id: country.id }
      let!(:city) { build :city, state_id: state.id }
      
      it "creates a new City" do
        city.state_id = state.id
        expect {
          post '/api/v1/cities', params: city.attributes, headers: valid_headers, as: :json
        }.to change(City, :count).by(1)
      end

      it "renders a JSON response with the new state" do
        city.state_id = state.id
        post '/api/v1/cities', params: city.attributes, headers: valid_headers, as: :json

        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      let!(:city) { build :city }
      # city needs state

      it "does not create a new City" do
        expect {
          post '/api/v1/cities',
               params: { city: city.attributes }, as: :json
        }.to change(City, :count).by(0)
      end

      it "renders a JSON response with errors for the new city" do
        post '/api/v1/cities',
             params: { city: city.attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PATCH /update" do
    let!(:city) { create :city }

    context "with valid parameters" do
      let(:new_attributes) {
        {name: 'Nova Maceió'}
      }

      before do
        patch "/api/v1/cities/#{city.id}",
              params: { city: new_attributes }, headers: valid_headers, as: :json
      end

      it "updates the requested city" do
        city.reload
        expect(response.body).to include_json(
          id: city.id,
          name: new_attributes[:name]
        )
      end

      it "renders a JSON response with the city" do
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the city" do
        patch "/api/v1/cities/#{city.id}",
              params: { city: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:city) { create :city }
    
    it "destroys the requested city" do
      expect {
        delete "/api/v1/cities/#{city.id}", headers: valid_headers, as: :json
      }.to change(City, :count).by(-1)
    end
  end
end
