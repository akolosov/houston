require 'spec_helper'

describe "server_commands/edit" do
  before(:each) do
    @server_command = assign(:server_command, stub_model(ServerCommand,
      :server => nil,
      :command => nil,
      :params => "MyString"
    ))
  end

  it "renders the edit server_command form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => server_commands_path(@server_command), :method => "post" do
      assert_select "input#server_command_server", :name => "server_command[server]"
      assert_select "input#server_command_command", :name => "server_command[command]"
      assert_select "input#server_command_params", :name => "server_command[params]"
    end
  end
end
