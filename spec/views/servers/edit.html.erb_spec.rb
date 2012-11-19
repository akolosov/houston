require 'spec_helper'

describe "servers/edit" do
  before(:each) do
    @server = assign(:server, stub_model(Server,
      :name => "MyString",
      :description => "MyText",
      :location => "MyString",
      :address => "MyString",
      :username => "MyString"
    ))
  end

  it "renders the edit server form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => servers_path(@server), :method => "post" do
      assert_select "input#server_name", :name => "server[name]"
      assert_select "textarea#server_description", :name => "server[description]"
      assert_select "input#server_location", :name => "server[location]"
      assert_select "input#server_address", :name => "server[address]"
      assert_select "input#server_username", :name => "server[username]"
    end
  end
end
