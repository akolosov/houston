require 'spec_helper'

describe "problem_solutions/show" do
  before(:each) do
    @problem_solution = assign(:problem_solution, stub_model(ProblemSolution,
      :problem => nil,
      :solution => nil,
      :params => "Params"
    ))
  end

  it "renders attributes in <p>" do
    render
    # Run the generator again with the --webrat flag if you want to use webrat matchers
    rendered.should match(//)
    rendered.should match(//)
    rendered.should match(/Params/)
  end
end
