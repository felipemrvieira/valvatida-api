require 'rails_helper'

RSpec.describe "api/v1/countries", type: :request do
  
  let(:valid_attributes) {
    {name: "Brasil"}
  }

  let(:invalid_attributes) {
    {name: nil}
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    before do
      Country.create! valid_attributes
    end

    it "renders a successful response" do
      get "/api/v1/countries", headers: valid_headers, as: :json
      expect(response).to be_successful
    end

    it "JSON body response contains expected country attributes" do
      get "/api/v1/countries", headers: valid_headers, as: :json
      expect(response.body).to include_json([
        name: "Brasil"
      ])
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      country = Country.create! valid_attributes
      get "/api/v1/countries/#{country.id}", as: :json
      expect(response).to be_successful
    end

    it "JSON body response contains expected country attributes" do
      country = Country.create! valid_attributes
      get "/api/v1/countries/#{country.id}", as: :json
      expect(response.body).to include_json(
        id: country.id,
        name: country.name
      )
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Country" do
        expect {
          post "/api/v1/countries",
               params: { country: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Country, :count).by(1)
      end

      it "renders a JSON response with the new country" do
        post "/api/v1/countries",
             params: { country: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Country" do
        expect {
          post "/api/v1/countries",
               params: { country: invalid_attributes }, as: :json
        }.to change(Country, :count).by(0)
      end

      it "renders a JSON response with errors for the new country" do
        post "/api/v1/countries",
             params: { country: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {name: 'Portugal'}
      }

      it "updates the requested country" do
        country = Country.create! valid_attributes
        patch "/api/v1/countries/#{country.id}",
              params: { country: new_attributes }, headers: valid_headers, as: :json
        country.reload
        expect(response.body).to include_json(
          id: country.id,
          name: 'Portugal'
        )
      end

      it "renders a JSON response with the country" do
        country = Country.create! valid_attributes
        patch "/api/v1/countries/#{country.id}",
              params: { country: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the country" do
        country = Country.create! valid_attributes
        patch "/api/v1/countries/#{country.id}",
              params: { country: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested country" do
      country = Country.create! valid_attributes
      expect {
        delete "/api/v1/countries/#{country.id}", headers: valid_headers, as: :json
      }.to change(Country, :count).by(-1)
    end
  end
end
