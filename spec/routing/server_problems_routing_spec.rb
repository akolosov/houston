require "spec_helper"

describe ServerProblemsController do
  describe "routing" do

    it "routes to #index" do
      get("/server_problems").should route_to("server_problems#index")
    end

    it "routes to #new" do
      get("/server_problems/new").should route_to("server_problems#new")
    end

    it "routes to #show" do
      get("/server_problems/1").should route_to("server_problems#show", :id => "1")
    end

    it "routes to #edit" do
      get("/server_problems/1/edit").should route_to("server_problems#edit", :id => "1")
    end

    it "routes to #create" do
      post("/server_problems").should route_to("server_problems#create")
    end

    it "routes to #update" do
      put("/server_problems/1").should route_to("server_problems#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/server_problems/1").should route_to("server_problems#destroy", :id => "1")
    end

  end
end
