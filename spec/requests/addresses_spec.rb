require 'rails_helper'

RSpec.describe "/addresses", type: :request do

  let(:valid_attributes) {
    {street: "Rua Carlos Tenório", number: "33"}
  }

  let(:invalid_attributes) {
    {street: nil}
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    
    let!(:address) { create :address }
    
    before do
      get '/api/v1/addresses', headers: valid_headers, as: :json
    end

    it "renders a successful response" do
      expect(response).to be_successful
    end

    it "JSON body response contains expected address attributes" do
      expect(response.body).to include_json([
        street: address.street
      ])
    end
  end

  describe "POST /create" do
    context "with valid parameters" do

      let!(:neighborhood) { create :neighborhood }
      let!(:address) { build :address, neighborhood_id: neighborhood.id }
      
      it "creates a new Address" do
        expect {
          post '/api/v1/addresses', params: address.attributes, headers: valid_headers, as: :json
        }.to change(Address, :count).by(1)
      end

      it "renders a JSON response with the new Address" do
        post '/api/v1/addresses', params: address.attributes, headers: valid_headers, as: :json

        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      let!(:address) { build :address }
      # address needs neighborhood

      it "does not create a new Address" do
        expect {
          post '/api/v1/addresses',
               params: { address: address.attributes }, as: :json
        }.to change(Address, :count).by(0)
      end

      it "renders a JSON response with errors for the new Address" do
        post '/api/v1/addresses',
             params: { address: address.attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PATCH /update" do
    let!(:address) { create :address }

    context "with valid parameters" do
      let(:new_attributes) {
        {street: "Nova Rua Carlos Tenório", number: "33b"}
      }

      before do
        patch "/api/v1/addresses/#{address.id}",
              params: { address: new_attributes }, headers: valid_headers, as: :json
      end

      it "updates the requested address" do
        address.reload
        expect(response.body).to include_json(
          id: address.id,
          street: new_attributes[:street],
          number: new_attributes[:number]
        )
      end

      it "renders a JSON response with the address" do
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the address" do
        patch "/api/v1/addresses/#{address.id}",
              params: { address: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:address) { create :address }
    
    it "destroys the requested address" do
      expect {
        delete "/api/v1/addresses/#{address.id}", headers: valid_headers, as: :json
      }.to change(Address, :count).by(-1)
    end
  end
end
