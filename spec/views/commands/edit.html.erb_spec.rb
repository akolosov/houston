require 'spec_helper'

describe "commands/edit" do
  before(:each) do
    @command = assign(:command, stub_model(Command,
      :name => "MyString",
      :description => "MyText",
      :command => "MyString",
      :params => "MyString",
      :with_params => false,
      :confirm => false
    ))
  end

  it "renders the edit command form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => commands_path(@command), :method => "post" do
      assert_select "input#command_name", :name => "command[name]"
      assert_select "textarea#command_description", :name => "command[description]"
      assert_select "input#command_command", :name => "command[command]"
      assert_select "input#command_params", :name => "command[params]"
      assert_select "input#command_with_params", :name => "command[with_params]"
      assert_select "input#command_confirm", :name => "command[confirm]"
    end
  end
end
