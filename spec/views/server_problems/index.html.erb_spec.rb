require 'spec_helper'

describe "server_problems/index" do
  before(:each) do
    assign(:server_problems, [
      stub_model(ServerProblem,
        :server => nil,
        :problem => nil
      ),
      stub_model(ServerProblem,
        :server => nil,
        :problem => nil
      )
    ])
  end

  it "renders a list of server_problems" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
  end
end
