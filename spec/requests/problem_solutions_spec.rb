require 'spec_helper'

describe "ProblemSolutions" do
  describe "GET /problem_solutions" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get problem_solutions_path
      response.status.should be(200)
    end
  end
end
