require "rails_helper"

RSpec.describe CourseGroupsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/course_groups").to route_to("course_groups#index")
    end

    it "routes to #show" do
      expect(get: "/course_groups/1").to route_to("course_groups#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/course_groups").to route_to("course_groups#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/course_groups/1").to route_to("course_groups#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/course_groups/1").to route_to("course_groups#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/course_groups/1").to route_to("course_groups#destroy", id: "1")
    end
  end
end
