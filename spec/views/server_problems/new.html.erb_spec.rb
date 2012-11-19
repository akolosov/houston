require 'spec_helper'

describe "server_problems/new" do
  before(:each) do
    assign(:server_problem, stub_model(ServerProblem,
      :server => nil,
      :problem => nil
    ).as_new_record)
  end

  it "renders new server_problem form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => server_problems_path, :method => "post" do
      assert_select "input#server_problem_server", :name => "server_problem[server]"
      assert_select "input#server_problem_problem", :name => "server_problem[problem]"
    end
  end
end
