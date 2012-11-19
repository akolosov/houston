require 'spec_helper'

describe "solutions/edit" do
  before(:each) do
    @solution = assign(:solution, stub_model(Solution,
      :name => "MyString",
      :description => "MyText",
      :problem => nil,
      :command => nil
    ))
  end

  it "renders the edit solution form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => solutions_path(@solution), :method => "post" do
      assert_select "input#solution_name", :name => "solution[name]"
      assert_select "textarea#solution_description", :name => "solution[description]"
      assert_select "input#solution_problem", :name => "solution[problem]"
      assert_select "input#solution_command", :name => "solution[command]"
    end
  end
end
