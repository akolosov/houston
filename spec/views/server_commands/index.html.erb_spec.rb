require 'spec_helper'

describe "server_commands/index" do
  before(:each) do
    assign(:server_commands, [
      stub_model(ServerCommand,
        :server => nil,
        :command => nil,
        :params => "Params"
      ),
      stub_model(ServerCommand,
        :server => nil,
        :command => nil,
        :params => "Params"
      )
    ])
  end

  it "renders a list of server_commands" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Params".to_s, :count => 2
  end
end
