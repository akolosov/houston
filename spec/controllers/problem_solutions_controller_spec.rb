require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe ProblemSolutionsController do

  # This should return the minimal set of attributes required to create a valid
  # ProblemSolution. As you add validations to ProblemSolution, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    { "problem" => "" }
  end

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # ProblemSolutionsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all problem_solutions as @problem_solutions" do
      problem_solution = ProblemSolution.create! valid_attributes
      get :index, {}, valid_session
      assigns(:problem_solutions).should eq([problem_solution])
    end
  end

  describe "GET show" do
    it "assigns the requested problem_solution as @problem_solution" do
      problem_solution = ProblemSolution.create! valid_attributes
      get :show, {:id => problem_solution.to_param}, valid_session
      assigns(:problem_solution).should eq(problem_solution)
    end
  end

  describe "GET new" do
    it "assigns a new problem_solution as @problem_solution" do
      get :new, {}, valid_session
      assigns(:problem_solution).should be_a_new(ProblemSolution)
    end
  end

  describe "GET edit" do
    it "assigns the requested problem_solution as @problem_solution" do
      problem_solution = ProblemSolution.create! valid_attributes
      get :edit, {:id => problem_solution.to_param}, valid_session
      assigns(:problem_solution).should eq(problem_solution)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new ProblemSolution" do
        expect {
          post :create, {:problem_solution => valid_attributes}, valid_session
        }.to change(ProblemSolution, :count).by(1)
      end

      it "assigns a newly created problem_solution as @problem_solution" do
        post :create, {:problem_solution => valid_attributes}, valid_session
        assigns(:problem_solution).should be_a(ProblemSolution)
        assigns(:problem_solution).should be_persisted
      end

      it "redirects to the created problem_solution" do
        post :create, {:problem_solution => valid_attributes}, valid_session
        response.should redirect_to(ProblemSolution.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved problem_solution as @problem_solution" do
        # Trigger the behavior that occurs when invalid params are submitted
        ProblemSolution.any_instance.stub(:save).and_return(false)
        post :create, {:problem_solution => { "problem" => "invalid value" }}, valid_session
        assigns(:problem_solution).should be_a_new(ProblemSolution)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        ProblemSolution.any_instance.stub(:save).and_return(false)
        post :create, {:problem_solution => { "problem" => "invalid value" }}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested problem_solution" do
        problem_solution = ProblemSolution.create! valid_attributes
        # Assuming there are no other problem_solutions in the database, this
        # specifies that the ProblemSolution created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        ProblemSolution.any_instance.should_receive(:update_attributes).with({ "problem" => "" })
        put :update, {:id => problem_solution.to_param, :problem_solution => { "problem" => "" }}, valid_session
      end

      it "assigns the requested problem_solution as @problem_solution" do
        problem_solution = ProblemSolution.create! valid_attributes
        put :update, {:id => problem_solution.to_param, :problem_solution => valid_attributes}, valid_session
        assigns(:problem_solution).should eq(problem_solution)
      end

      it "redirects to the problem_solution" do
        problem_solution = ProblemSolution.create! valid_attributes
        put :update, {:id => problem_solution.to_param, :problem_solution => valid_attributes}, valid_session
        response.should redirect_to(problem_solution)
      end
    end

    describe "with invalid params" do
      it "assigns the problem_solution as @problem_solution" do
        problem_solution = ProblemSolution.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ProblemSolution.any_instance.stub(:save).and_return(false)
        put :update, {:id => problem_solution.to_param, :problem_solution => { "problem" => "invalid value" }}, valid_session
        assigns(:problem_solution).should eq(problem_solution)
      end

      it "re-renders the 'edit' template" do
        problem_solution = ProblemSolution.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        ProblemSolution.any_instance.stub(:save).and_return(false)
        put :update, {:id => problem_solution.to_param, :problem_solution => { "problem" => "invalid value" }}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested problem_solution" do
      problem_solution = ProblemSolution.create! valid_attributes
      expect {
        delete :destroy, {:id => problem_solution.to_param}, valid_session
      }.to change(ProblemSolution, :count).by(-1)
    end

    it "redirects to the problem_solutions list" do
      problem_solution = ProblemSolution.create! valid_attributes
      delete :destroy, {:id => problem_solution.to_param}, valid_session
      response.should redirect_to(problem_solutions_url)
    end
  end

end
