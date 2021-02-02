require 'rails_helper'

RSpec.describe "/states", type: :request do

  let(:valid_attributes) {
    {name: "Alagoas"}
  }

  let(:invalid_attributes) {
    {name: nil}
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    
    let!(:state) { create :state }
    
    before do
      get '/api/v1/states', headers: valid_headers, as: :json
    end

    it "renders a successful response" do
      expect(response).to be_successful
    end

    it "JSON body response contains expected country attributes" do
      expect(response.body).to include_json([
        name: state.name
      ])
    end
  end

  describe "POST /create" do
    context "with valid parameters" do

      let!(:country) { create :country }
      let!(:state) { build :state }
      
      it "creates a new State" do
        state.country_id = country.id
        expect {
          post '/api/v1/states', params: state.attributes, headers: valid_headers, as: :json
        }.to change(State, :count).by(1)
      end

      it "renders a JSON response with the new state" do
        state.country_id = country.id
        post '/api/v1/states', params: state.attributes, headers: valid_headers, as: :json

        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      let!(:state) { build :state }

      it "does not create a new State" do
        expect {
          post '/api/v1/states',
               params: { state: state.attributes }, as: :json
        }.to change(State, :count).by(0)
      end

      it "renders a JSON response with errors for the new state" do
        post '/api/v1/states',
             params: { state: state.attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PATCH /update" do
    let!(:state) { create :state }

    context "with valid parameters" do
      let(:new_attributes) {
        {name: 'Nova Alagoas'}
      }
      
      before do
        patch "/api/v1/states/#{state.id}",
              params: { state: new_attributes }, headers: valid_headers, as: :json
      end

      it "updates the requested state" do
        state.reload
        expect(response.body).to include_json(
          id: state.id,
          name: new_attributes[:name]
        )
      end

      it "renders a JSON response with the state" do
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the state" do
        patch "/api/v1/states/#{state.id}",
              params: { state: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:state) { create :state }
    
    it "destroys the requested state" do
      expect {
        delete "/api/v1/states/#{state.id}", headers: valid_headers, as: :json
      }.to change(State, :count).by(-1)
    end
  end
end
