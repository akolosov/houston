require "spec_helper"

describe CommandsController do
  describe "routing" do

    it "routes to #index" do
      get("/commands").should route_to("commands#index")
    end

    it "routes to #new" do
      get("/commands/new").should route_to("commands#new")
    end

    it "routes to #show" do
      get("/commands/1").should route_to("commands#show", :id => "1")
    end

    it "routes to #edit" do
      get("/commands/1/edit").should route_to("commands#edit", :id => "1")
    end

    it "routes to #create" do
      post("/commands").should route_to("commands#create")
    end

    it "routes to #update" do
      put("/commands/1").should route_to("commands#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/commands/1").should route_to("commands#destroy", :id => "1")
    end

  end
end
