class ProblemSolutionsController < ApplicationController
  skip_before_filter :require_login

  load_and_authorize_resource

  # GET /problem_solutions/execute
  def execute
    @problem_solution = ProblemSolution.find(params[:problem_solution][:id])
    @command = Command.find(params[:problem_solution][:command_id])
    @server = Server.find(params[:problem_solution][:server_id])
  end
  
  # GET /problem_solutions/run
  def run
    if (params[:id])
      @problem_solution = ProblemSolution.find(params[:id])
    end

    if (params[:problem_id]) 
      @problem_solutions = ProblemSolution.find_all_by_problem_id(params[:problem_id])
      @problem_solution = @problem_solutions.first
    end

    if (params[:solution_id]) 
      @problem_solutions = ProblemSolution.find_all_by_solution_id(params[:solution_id])
      @problem_solution = @problem_solutions.first
    end

    if (params[:server_id]) 
      @server = Server.find(params[:server_id])
      if ServerCommand.command_for_server(@problem_solution.solution.command, @server)
        @params = ServerCommand.command_for_server(@problem_solution.solution.command, @server).params
      else
        @params = ""
      end
    else
      if ServerCommand.one_command(@problem_solution.solution.command)
        @params = ServerCommand.one_command(@problem_solution.solution.command).params
      else
        @params = ""
      end
    end
  end

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
