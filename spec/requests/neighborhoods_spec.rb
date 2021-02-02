require 'rails_helper'

RSpec.describe "/neighborhoods", type: :request do

  let(:valid_attributes) {
    {name: "Ponta verde"}
  }

  let(:invalid_attributes) {
    {name: nil}
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    
    let!(:neighborhood) { create :neighborhood }
    
    before do
      get '/api/v1/neighborhoods', headers: valid_headers, as: :json
    end

    it "renders a successful response" do
      expect(response).to be_successful
    end

    it "JSON body response contains expected neighborhood attributes" do
      expect(response.body).to include_json([
        name: neighborhood.name
      ])
    end
  end

  describe "POST /create" do
    context "with valid parameters" do

      let!(:city) { create :city }
      let!(:neighborhood) { build :neighborhood, city_id: city.id }
      
      it "creates a new Neighborhood" do
        expect {
          post '/api/v1/neighborhoods', params: neighborhood.attributes, headers: valid_headers, as: :json
        }.to change(Neighborhood, :count).by(1)
      end

      it "renders a JSON response with the new Neighborhood" do
        post '/api/v1/neighborhoods', params: neighborhood.attributes, headers: valid_headers, as: :json

        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      let!(:neighborhood) { build :neighborhood }
      # neighborhood needs city

      it "does not create a new Neighborhood" do
        expect {
          post '/api/v1/neighborhoods',
               params: { neighborhood: neighborhood.attributes }, as: :json
        }.to change(Neighborhood, :count).by(0)
      end

      it "renders a JSON response with errors for the new neighborhood" do
        post '/api/v1/neighborhoods',
             params: { neighborhood: neighborhood.attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PATCH /update" do
    let!(:neighborhood) { create :neighborhood }

    context "with valid parameters" do
      let(:new_attributes) {
        {name: 'Nova Ponta Verde'}
      }

      before do
        patch "/api/v1/neighborhoods/#{neighborhood.id}",
              params: { neighborhood: new_attributes }, headers: valid_headers, as: :json
      end

      it "updates the requested neighborhood" do
        neighborhood.reload
        expect(response.body).to include_json(
          id: neighborhood.id,
          name: new_attributes[:name]
        )
      end

      it "renders a JSON response with the neighborhood" do
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the neighborhood" do
        patch "/api/v1/neighborhoods/#{neighborhood.id}",
              params: { neighborhood: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:neighborhood) { create :neighborhood }
    
    it "destroys the requested neighborhood" do
      expect {
        delete "/api/v1/neighborhoods/#{neighborhood.id}", headers: valid_headers, as: :json
      }.to change(Neighborhood, :count).by(-1)
    end
  end
end
