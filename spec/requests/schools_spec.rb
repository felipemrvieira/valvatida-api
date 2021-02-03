require 'rails_helper'

RSpec.describe "/schools", type: :request do

  let(:valid_attributes) {
    {name: "Escola santa maria"}
  }

  let(:invalid_attributes) {
    {name: nil}
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    
    let!(:school) { create :school }
    
    before do
      get '/api/v1/schools', headers: valid_headers, as: :json
    end

    it "renders a successful response" do
      expect(response).to be_successful
    end

    it "JSON body response contains expected school attributes" do
      expect(response.body).to include_json([
        name: school.name
      ])
    end
  end

  describe "POST /create" do
    context "with valid parameters" do

      let!(:address) { create :address }
      let!(:school) { build :school, address_id: address.id }
      
      it "creates a new School" do
        expect {
          post '/api/v1/schools', params: school.attributes, headers: valid_headers, as: :json
        }.to change(School, :count).by(1)
      end

      it "renders a JSON response with the new School" do
        post '/api/v1/schools', params: school.attributes, headers: valid_headers, as: :json

        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      let!(:school) { build :school }
      # school needs address

      it "does not create a new School" do
        expect {
          post '/api/v1/schools',
               params: { school: school.attributes }, as: :json
        }.to change(School, :count).by(0)
      end

      it "renders a JSON response with errors for the new School" do
        post '/api/v1/schools',
             params: { school: school.attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PATCH /update" do
    let!(:school) { create :school }

    context "with valid parameters" do
      let(:new_attributes) {
        {name: "Nova Escola"}
      }

      before do
        patch "/api/v1/schools/#{school.id}",
              params: { school: new_attributes }, headers: valid_headers, as: :json
      end

      it "updates the requested school" do
        school.reload
        expect(response.body).to include_json(
          id: school.id,
          name: new_attributes[:name]
        )
      end

      it "renders a JSON response with the school" do
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the school" do
        patch "/api/v1/schools/#{school.id}",
              params: { school: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:school) { create :school }
    
    it "destroys the requested school" do
      expect {
        delete "/api/v1/schools/#{school.id}", headers: valid_headers, as: :json
      }.to change(School, :count).by(-1)
    end
  end
end
