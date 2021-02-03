require 'rails_helper'

RSpec.describe "/courses", type: :request do

  let(:valid_attributes) {
    {title: "Programação com Ruby"}
  }

  let(:invalid_attributes) {
    {title: nil}
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    
    let!(:course) { create :course }
    
    before do
      get '/api/v1/courses', headers: valid_headers, as: :json
    end

    it "renders a successful response" do
      expect(response).to be_successful
    end

    it "JSON body response contains expected course attributes" do
      expect(response.body).to include_json([
        title: course.title
      ])
    end
  end

  describe "POST /create" do
    context "with valid parameters" do

      let!(:school) { create :school }
      let!(:course) { build :course, school_id: school.id }
      
      it "creates a new Course" do
        expect {
          post '/api/v1/courses', params: course.attributes, headers: valid_headers, as: :json
        }.to change(Course, :count).by(1)
      end

      it "renders a JSON response with the new Course" do
        post '/api/v1/courses', params: course.attributes, headers: valid_headers, as: :json

        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with valid parameters and CourseGroup" do

      let!(:school) { create :school }
      let!(:course_group) { create :course_group }
      let!(:course) { build :course, course_group_id: course_group.id, school_id: school.id }
      
      it "creates a new Course" do
        expect {
          post '/api/v1/courses', params: course.attributes, headers: valid_headers, as: :json
        }.to change(Course, :count).by(1)
      end

      it "renders a JSON response with the new Course" do
        post '/api/v1/courses', params: course.attributes, headers: valid_headers, as: :json

        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      let!(:course) { build :course, title: nil }

      it "does not create a new Course" do
        expect {
          post '/api/v1/courses',
               params: { course: course.attributes }, as: :json
        }.to change(Course, :count).by(0)
      end

      it "renders a JSON response with errors for the new Course" do
        post '/api/v1/courses',
             params: { course: course.attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PATCH /update" do
    let!(:course) { create :course }

    context "with valid parameters" do
      let(:new_attributes) {
        {title: "Novo curso"}
      }

      before do
        patch "/api/v1/courses/#{course.id}",
              params: { course: new_attributes }, headers: valid_headers, as: :json
      end

      it "updates the requested course" do
        course.reload
        expect(response.body).to include_json(
          id: course.id,
          title: new_attributes[:title]
        )
      end

      it "renders a JSON response with the course" do
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the course" do
        patch "/api/v1/courses/#{course.id}",
              params: { course: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:course) { create :course }
    
    it "destroys the requested course" do
      expect {
        delete "/api/v1/courses/#{course.id}", headers: valid_headers, as: :json
      }.to change(Course, :count).by(-1)
    end
  end
end
