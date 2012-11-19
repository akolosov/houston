require 'spec_helper'

describe "commands/show" do
  before(:each) do
    @command = assign(:command, stub_model(Command,
      :name => "Name",
      :description => "MyText",
      :command => "Command",
      :params => "Params",
      :with_params => false,
      :confirm => false
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(/Name/)
    rendered.should match(/MyText/)
    rendered.should match(/Command/)
    rendered.should match(/Params/)
    rendered.should match(/false/)
    rendered.should match(/false/)
  end
end
