require 'spec_helper'

describe "server_commands/show" do
  before(:each) do
    @server_command = assign(:server_command, stub_model(ServerCommand,
      :server => nil,
      :command => nil,
      :params => "Params"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/Params/)
  end
end
