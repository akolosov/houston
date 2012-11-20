class ProblemSolutionsController < ApplicationController
  # GET /problem_solutions
  # GET /problem_solutions.json
  def index
    @problem_solutions = ProblemSolution.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @problem_solutions }
    end
  end

  # GET /problem_solutions/1
  # GET /problem_solutions/1.json
  def show
    @problem_solution = ProblemSolution.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @problem_solution }
    end
  end

  # GET /problem_solutions/new
  # GET /problem_solutions/new.json
  def new
    @problem_solution = ProblemSolution.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @problem_solution }
    end
  end

  # GET /problem_solutions/1/edit
  def edit
    @problem_solution = ProblemSolution.find(params[:id])
  end

  # POST /problem_solutions
  # POST /problem_solutions.json
  def create
    @problem_solution = ProblemSolution.new(params[:problem_solution])

    respond_to do |format|
      if @problem_solution.save
        format.html { redirect_to @problem_solution, notice: 'Problem solution was successfully created.' }
        format.json { render json: @problem_solution, status: :created, location: @problem_solution }
      else
        format.html { render action: "new" }
        format.json { render json: @problem_solution.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /problem_solutions/1
  # PUT /problem_solutions/1.json
  def update
    @problem_solution = ProblemSolution.find(params[:id])

    respond_to do |format|
      if @problem_solution.update_attributes(params[:problem_solution])
        format.html { redirect_to @problem_solution, notice: 'Problem solution was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @problem_solution.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /problem_solutions/1
  # DELETE /problem_solutions/1.json
  def destroy
    @problem_solution = ProblemSolution.find(params[:id])
    @problem_solution.destroy

    respond_to do |format|
      format.html { redirect_to problem_solutions_url }
      format.json { head :no_content }
    end
  end
end
