require 'rails_helper'

RSpec.describe "/states", type: :request do

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      country = Country.create(name: 'Brasil')
      State.create(name: 'Alagoas', country_id: country.id)
      get states_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      country = Country.create(name: 'Brasil')
      state = State.create(name: 'Alagoas', country_id: country.id)
      get state_url(state), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new State" do
        expect {
          post states_url,
               params: { state: valid_attributes }, headers: valid_headers, as: :json
        }.to change(State, :count).by(1)
      end

      it "renders a JSON response with the new state" do
        post states_url,
             params: { state: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new State" do
        expect {
          post states_url,
               params: { state: invalid_attributes }, as: :json
        }.to change(State, :count).by(0)
      end

      it "renders a JSON response with errors for the new state" do
        post states_url,
             params: { state: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested state" do
        state = State.create! valid_attributes
        patch state_url(state),
              params: { state: new_attributes }, headers: valid_headers, as: :json
        state.reload
        skip("Add assertions for updated state")
      end

      it "renders a JSON response with the state" do
        state = State.create! valid_attributes
        patch state_url(state),
              params: { state: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the state" do
        state = State.create! valid_attributes
        patch state_url(state),
              params: { state: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested state" do
      state = State.create! valid_attributes
      expect {
        delete state_url(state), headers: valid_headers, as: :json
      }.to change(State, :count).by(-1)
    end
  end
end
