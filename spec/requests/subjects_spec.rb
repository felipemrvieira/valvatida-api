require 'rails_helper'

RSpec.describe "/subjects", type: :request do

  let(:valid_attributes) {
    {title: "POO"}
  }

  let(:invalid_attributes) {
    {title: nil}
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    
    let!(:subject) { create :subject }
    
    before do
      get '/api/v1/subjects', headers: valid_headers, as: :json
    end

    it "renders a successful response" do
      expect(response).to be_successful
    end

    it "JSON body response contains expected subject attributes" do
      expect(response.body).to include_json([
        title: subject.title
      ])
    end
  end

  describe "POST /create" do
    context "with valid parameters" do

      let!(:course) { create :course }
      let!(:subject) { build :subject, course_id: course.id }
      
      it "creates a new Subject" do
        expect {
          post '/api/v1/subjects', params: subject.attributes, headers: valid_headers, as: :json
        }.to change(Subject, :count).by(1)
      end

      it "renders a JSON response with the new Subject" do
        post '/api/v1/subjects', params: subject.attributes, headers: valid_headers, as: :json

        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      let!(:subject) { build :subject, title: nil }

      it "does not create a new Subject" do
        expect {
          post '/api/v1/subjects',
               params: { subject: subject.attributes }, as: :json
        }.to change(Subject, :count).by(0)
      end

      it "renders a JSON response with errors for the new Subject" do
        post '/api/v1/subjects',
             params: { subject: subject.attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PATCH /update" do
    let!(:subject) { create :subject }

    context "with valid parameters" do
      let(:new_attributes) {
        {title: "Novo assunto"}
      }

      before do
        patch "/api/v1/subjects/#{subject.id}",
              params: { subject: new_attributes }, headers: valid_headers, as: :json
      end

      it "updates the requested subject" do
        subject.reload
        expect(response.body).to include_json(
          id: subject.id,
          title: new_attributes[:title]
        )
      end

      it "renders a JSON response with the subject" do
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the subject" do
        patch "/api/v1/subjects/#{subject.id}",
              params: { subject: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:subject) { create :subject }
    
    it "destroys the requested subject" do
      expect {
        delete "/api/v1/subjects/#{subject.id}", headers: valid_headers, as: :json
      }.to change(Subject, :count).by(-1)
    end
  end
end
