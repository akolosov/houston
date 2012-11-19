require 'spec_helper'

describe "servers/index" do
  before(:each) do
    assign(:servers, [
      stub_model(Server,
        :name => "Name",
        :description => "MyText",
        :location => "Location",
        :address => "Address",
        :username => "Username"
      ),
      stub_model(Server,
        :name => "Name",
        :description => "MyText",
        :location => "Location",
        :address => "Address",
        :username => "Username"
      )
    ])
  end

  it "renders a list of servers" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Location".to_s, :count => 2
    assert_select "tr>td", :text => "Address".to_s, :count => 2
    assert_select "tr>td", :text => "Username".to_s, :count => 2
  end
end
