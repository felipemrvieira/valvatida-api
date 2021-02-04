require 'rails_helper'

RSpec.describe "/student_auth", type: :request do

  let!(:address) { create :address }


  let(:valid_attributes) {
    {
      name: 'Felipe Maciel',
      email: 'felipemrvieira@gmail.com',
      password: '123123',
      address_id: address.id
    }
  }

  let(:invalid_attributes) {
    {
      name: 'Felipe Maciel',
      email: 'felipemrvieira@gmail.com',
      password: nil
    }
  }

  let(:valid_headers) {
    {}
  }

  describe "POST /api/v1/student_auth/sign_in" do
    context "with valid parameters" do

      let!(:student) { create :student, email: 'felipemrvieira@gmail.com', password: '123123' }

      it 'gives you an authentication code if you are an existing user and you satisfy the password' do
        # login
        post '/api/v1/student_auth/sign_in', params: valid_attributes, headers: valid_headers, as: :json
        # puts "#{response.headers.inspect}"
        # puts "#{response.body.inspect}"
        expect(response.has_header?('access-token')).to eq(true)
      end
  
      it 'gives you a status 200 on signing in ' do
        # login
        post '/api/v1/student_auth/sign_in', params: valid_attributes, headers: valid_headers, as: :json
        expect(response.status).to eq(200)
      end
    end
  end

  describe "POST /api/v1/student_auth" do
    context "with valid parameters" do
      
      it "creates a new Student" do
        expect {
          post '/api/v1/student_auth/', params: valid_attributes, headers: valid_headers, as: :json
        }.to change(Student, :count).by(1)
      end

      it "renders a JSON response with the new Student" do
        post '/api/v1/student_auth/', params: valid_attributes, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end

    end
  end

  
end
