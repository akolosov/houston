require "spec_helper"

describe ProblemSolutionsController do
  describe "routing" do

    it "routes to #index" do
      get("/problem_solutions").should route_to("problem_solutions#index")
    end

    it "routes to #new" do
      get("/problem_solutions/new").should route_to("problem_solutions#new")
    end

    it "routes to #show" do
      get("/problem_solutions/1").should route_to("problem_solutions#show", :id => "1")
    end

    it "routes to #edit" do
      get("/problem_solutions/1/edit").should route_to("problem_solutions#edit", :id => "1")
    end

    it "routes to #create" do
      post("/problem_solutions").should route_to("problem_solutions#create")
    end

    it "routes to #update" do
      put("/problem_solutions/1").should route_to("problem_solutions#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/problem_solutions/1").should route_to("problem_solutions#destroy", :id => "1")
    end

  end
end
