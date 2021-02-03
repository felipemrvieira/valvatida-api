require 'rails_helper'

RSpec.describe "/questions", type: :request do

  let(:valid_attributes) {
    {label: "Leia com atenção", command: "Qual o nome do primeiro...?"}
  }

  let(:invalid_attributes) {
    {label: nil, command: nil}
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    
    let!(:question) { create :question }
    
    before do
      get '/api/v1/questions', headers: valid_headers, as: :json
    end

    it "renders a successful response" do
      expect(response).to be_successful
    end

    it "JSON body response contains expected question attributes" do
      expect(response.body).to include_json([
        label: question.label,
        command: question.command
      ])
    end
  end

  describe "POST /create" do
    context "with valid parameters" do

      let!(:subject) { create :subject }
      let!(:teacher) { create :teacher }
      let!(:question) { build :question, subject_id: subject.id, teacher_id: teacher.id }
      
      it "creates a new Question" do
        expect {
          post '/api/v1/questions', params: question.attributes, headers: valid_headers, as: :json
        }.to change(Question, :count).by(1)
      end

      it "renders a JSON response with the new Question" do
        post '/api/v1/questions', params: question.attributes, headers: valid_headers, as: :json

        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      let!(:question) { build :question }
      # question needs teacher and subject

      it "does not create a new Question" do
        expect {
          post '/api/v1/questions',
               params: { question: question.attributes }, as: :json
        }.to change(Question, :count).by(0)
      end

      it "renders a JSON response with errors for the new Question" do
        post '/api/v1/questions',
             params: { question: question.attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PATCH /update" do
    let!(:question) { create :question }

    context "with valid parameters" do
      let(:new_attributes) {
        {label: "Leia com atenção editado", command: "Qual o nome do primeiro...? editado"}
      }

      before do
        patch "/api/v1/questions/#{question.id}",
              params: { question: new_attributes }, headers: valid_headers, as: :json
      end

      it "updates the requested question" do
        question.reload
        expect(response.body).to include_json(
          id: question.id,
          label: new_attributes[:label],
          command: new_attributes[:command]
        )
      end

      it "renders a JSON response with the question" do
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the question" do
        patch "/api/v1/questions/#{question.id}",
              params: { question: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:question) { create :question }
    
    it "destroys the requested question" do
      expect {
        delete "/api/v1/questions/#{question.id}", headers: valid_headers, as: :json
      }.to change(Question, :count).by(-1)
    end
  end
end
