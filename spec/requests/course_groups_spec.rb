require 'rails_helper'

RSpec.describe "/course_groups", type: :request do

  let(:valid_attributes) {
    {title: "1 ano"}
  }

  let(:invalid_attributes) {
    {title: nil}
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    
    let!(:course_group) { create :course_group }
    
    before do
      get '/api/v1/course_groups', headers: valid_headers, as: :json
    end

    it "renders a successful response" do
      expect(response).to be_successful
    end

    it "JSON body response contains expected course_group attributes" do
      expect(response.body).to include_json([
        title: course_group.title
      ])
    end
  end

  describe "POST /create" do
    context "with valid parameters" do

      let!(:course_group) { build :course_group }
      
      it "creates a new Course Group" do
        expect {
          post '/api/v1/course_groups', params: course_group.attributes, headers: valid_headers, as: :json
        }.to change(CourseGroup, :count).by(1)
      end

      it "renders a JSON response with the new CourseGroup" do
        post '/api/v1/course_groups', params: course_group.attributes, headers: valid_headers, as: :json

        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      let!(:course_group) { build :course_group, title: nil }

      it "does not create a new CourseGroup" do
        expect {
          post '/api/v1/course_groups',
               params: { course_group: course_group.attributes }, as: :json
        }.to change(CourseGroup, :count).by(0)
      end

      it "renders a JSON response with errors for the new CourseGroup" do
        post '/api/v1/course_groups',
             params: { course_group: course_group.attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PATCH /update" do
    let!(:course_group) { create :course_group }

    context "with valid parameters" do
      let(:new_attributes) {
        {title: "Novo curso"}
      }

      before do
        patch "/api/v1/course_groups/#{course_group.id}",
              params: { course_group: new_attributes }, headers: valid_headers, as: :json
      end

      it "updates the requested course_group" do
        course_group.reload
        expect(response.body).to include_json(
          id: course_group.id,
          title: new_attributes[:title]
        )
      end

      it "renders a JSON response with the course_group" do
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the course_group" do
        patch "/api/v1/course_groups/#{course_group.id}",
              params: { course_group: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:course_group) { create :course_group }
    
    it "destroys the requested course_group" do
      expect {
        delete "/api/v1/course_groups/#{course_group.id}", headers: valid_headers, as: :json
      }.to change(CourseGroup, :count).by(-1)
    end
  end
end
