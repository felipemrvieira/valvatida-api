require "rails_helper"

RSpec.describe MultipleQuestionOptionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/multiple_question_options").to route_to("multiple_question_options#index")
    end

    it "routes to #show" do
      expect(get: "/multiple_question_options/1").to route_to("multiple_question_options#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/multiple_question_options").to route_to("multiple_question_options#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/multiple_question_options/1").to route_to("multiple_question_options#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/multiple_question_options/1").to route_to("multiple_question_options#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/multiple_question_options/1").to route_to("multiple_question_options#destroy", id: "1")
    end
  end
end
