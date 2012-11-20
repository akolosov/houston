require 'spec_helper'

describe "problem_solutions/index" do
  before(:each) do
    assign(:problem_solutions, [
      stub_model(ProblemSolution,
        :problem => nil,
        :solution => nil,
        :params => "Params"
      ),
      stub_model(ProblemSolution,
        :problem => nil,
        :solution => nil,
        :params => "Params"
      )
    ])
  end

  it "renders a list of problem_solutions" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Params".to_s, :count => 2
  end
end
