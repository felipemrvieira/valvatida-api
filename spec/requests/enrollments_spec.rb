require 'rails_helper'

RSpec.describe "/enrollments", type: :request do

  let(:valid_attributes) {
    {}
  }

  let(:invalid_attributes) {
    {course_id: nil}
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    
    let!(:enrollment) { create :enrollment }
    
    before do
      get '/api/v1/enrollments', headers: valid_headers, as: :json
    end

    it "renders a successful response" do
      expect(response).to be_successful
    end

    it "JSON body response contains expected enrollment attributes" do
      expect(response.body).to include_json([
        course_id: enrollment.course_id,
        student_id: enrollment.student_id
      ])
    end
  end

  describe "POST /create" do
    context "with valid parameters" do

      let!(:course) { create :course }
      let!(:student) { create :student }
      let!(:enrollment) { build :enrollment, student_id: student.id, course_id: course.id }
      
      it "creates a new Enrollment" do
        expect {
          post '/api/v1/enrollments', params: enrollment.attributes, headers: valid_headers, as: :json
        }.to change(Enrollment, :count).by(1)
      end

      it "renders a JSON response with the new Enrollment" do
        post '/api/v1/enrollments', params: enrollment.attributes, headers: valid_headers, as: :json

        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      let!(:enrollment) { build :enrollment }
      # enrollment needs student and course

      it "does not create a new Enrollment" do
        expect {
          post '/api/v1/enrollments',
               params: { enrollment: enrollment.attributes }, as: :json
        }.to change(Enrollment, :count).by(0)
      end

      it "renders a JSON response with errors for the new Enrollment" do
        post '/api/v1/enrollments',
             params: { enrollment: enrollment.attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "PATCH /update" do
    let!(:enrollment) { create :enrollment }
    let!(:course) { create :course }

    context "with valid parameters" do
      let(:new_attributes) {
        {course_id: course.id}
      }

      before do
        patch "/api/v1/enrollments/#{enrollment.id}",
              params: { enrollment: new_attributes }, headers: valid_headers, as: :json
      end

      it "updates the requested enrollment" do
        enrollment.reload
        expect(response.body).to include_json(
          id: enrollment.id,
          course_id: new_attributes[:course_id]
        )
      end

      it "renders a JSON response with the enrollment" do
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the enrollment" do
        patch "/api/v1/enrollments/#{enrollment.id}",
              params: { enrollment: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq("application/json")
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:enrollment) { create :enrollment }
    
    it "destroys the requested enrollment" do
      expect {
        delete "/api/v1/enrollments/#{enrollment.id}", headers: valid_headers, as: :json
      }.to change(Enrollment, :count).by(-1)
    end
  end
end
