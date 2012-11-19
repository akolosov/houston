require 'spec_helper'

describe "server_problems/edit" do
  before(:each) do
    @server_problem = assign(:server_problem, stub_model(ServerProblem,
      :server => nil,
      :problem => nil
    ))
  end

  it "renders the edit server_problem form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => server_problems_path(@server_problem), :method => "post" do
      assert_select "input#server_problem_server", :name => "server_problem[server]"
      assert_select "input#server_problem_problem", :name => "server_problem[problem]"
    end
  end
end
