require "spec_helper"

describe ServerCommandsController do
  describe "routing" do

    it "routes to #index" do
      get("/server_commands").should route_to("server_commands#index")
    end

    it "routes to #new" do
      get("/server_commands/new").should route_to("server_commands#new")
    end

    it "routes to #show" do
      get("/server_commands/1").should route_to("server_commands#show", :id => "1")
    end

    it "routes to #edit" do
      get("/server_commands/1/edit").should route_to("server_commands#edit", :id => "1")
    end

    it "routes to #create" do
      post("/server_commands").should route_to("server_commands#create")
    end

    it "routes to #update" do
      put("/server_commands/1").should route_to("server_commands#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/server_commands/1").should route_to("server_commands#destroy", :id => "1")
    end

  end
end
