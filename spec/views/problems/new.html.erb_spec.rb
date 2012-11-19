require 'spec_helper'

describe "problems/new" do
  before(:each) do
    assign(:problem, stub_model(Problem,
      :name => "MyString",
      :description => "MyText",
      :server => nil
    ).as_new_record)
  end

  it "renders new problem form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => problems_path, :method => "post" do
      assert_select "input#problem_name", :name => "problem[name]"
      assert_select "textarea#problem_description", :name => "problem[description]"
      assert_select "input#problem_server", :name => "problem[server]"
    end
  end
end
