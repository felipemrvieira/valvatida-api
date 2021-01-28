require 'rails_helper'

RSpec.describe "/countries", type: :request do
  
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
    it "renders a successful response" do
      Country.create! valid_attributes
      get countries_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      country = Country.create! valid_attributes
      get country_url(country), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Country" do
        expect {
          post countries_url,
               params: { country: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Country, :count).by(1)
      end

      it "renders a JSON response with the new country" do
        post countries_url,
             params: { country: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Country" do
        expect {
          post countries_url,
               params: { country: invalid_attributes }, as: :json
        }.to change(Country, :count).by(0)
      end

      it "renders a JSON response with errors for the new country" do
        post countries_url,
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
        patch country_url(country),
              params: { country: new_attributes }, headers: valid_headers, as: :json
        country.reload
        skip("Add assertions for updated state")
      end

      it "renders a JSON response with the country" do
        country = Country.create! valid_attributes
        patch country_url(country),
              params: { country: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the country" do
        country = Country.create! valid_attributes
        patch country_url(country),
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
        delete country_url(country), headers: valid_headers, as: :json
      }.to change(Country, :count).by(-1)
    end
  end
end
