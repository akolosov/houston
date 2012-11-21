require 'spec_helper'

describe "commands/new" do
  before(:each) do
    assign(:command, stub_model(Command,
      :name => "MyString",
      :description => "MyText",
      :command => "MyString",
      :confirm => false
    ).as_new_record)
  end

  it "renders new command form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => commands_path, :method => "post" do
      assert_select "input#command_name", :name => "command[name]"
      assert_select "textarea#command_description", :name => "command[description]"
      assert_select "input#command_command", :name => "command[command]"
      assert_select "input#command_confirm", :name => "command[confirm]"
    end
  end
end
