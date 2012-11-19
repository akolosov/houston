require 'spec_helper'

describe "server_problems/show" do
  before(:each) do
    @server_problem = assign(:server_problem, stub_model(ServerProblem,
      :server => nil,
      :problem => nil
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
  end
end
