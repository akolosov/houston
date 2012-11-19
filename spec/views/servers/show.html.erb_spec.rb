require 'spec_helper'

describe "servers/show" do
  before(:each) do
    @server = assign(:server, stub_model(Server,
      :name => "Name",
      :description => "MyText",
      :location => "Location",
      :address => "Address",
      :username => "Username"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
    rendered.should match(/Location/)
    rendered.should match(/Address/)
    rendered.should match(/Username/)
  end
end
