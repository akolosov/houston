require 'spec_helper'

describe "problem_solutions/new" do
  before(:each) do
    assign(:problem_solution, stub_model(ProblemSolution,
      :problem => nil,
      :solution => nil,
      :params => "MyString"
    ).as_new_record)
  end

  it "renders new problem_solution form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => problem_solutions_path, :method => "post" do
      assert_select "input#problem_solution_problem", :name => "problem_solution[problem]"
      assert_select "input#problem_solution_solution", :name => "problem_solution[solution]"
      assert_select "input#problem_solution_params", :name => "problem_solution[params]"
    end
  end
end
