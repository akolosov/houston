require 'spec_helper'

describe "commands/index" do
  before(:each) do
    assign(:commands, [
      stub_model(Command,
        :name => "Name",
        :description => "MyText",
        :command => "Command",
        :confirm => false
      ),
      stub_model(Command,
        :name => "Name",
        :description => "MyText",
        :command => "Command",
        :confirm => false
      )
    ])
  end

  it "renders a list of commands" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => "Name".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => "Command".to_s, :count => 2
    assert_select "tr>td", :text => false.to_s, :count => 2
  end
end
