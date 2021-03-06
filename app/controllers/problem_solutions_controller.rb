# encoding: utf-8
class ProblemSolutionsController < ApplicationController
  before_filter :require_login

  load_and_authorize_resource

  # GET /problem_solutions
  # GET /problem_solutions.json
  def index
    params[:problem_id] ?
        @problem_solutions = ProblemSolution.paginate(page: params[:page], per_page: 5).order('updated_at ASC').find_all_by_problem_id(params[:problem_id]) :
        @problem_solutions = ProblemSolution.accessible_by(current_ability).paginate(page: params[:page], per_page: 5).order('updated_at DESC')

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /problem_solutions/new
  # GET /problem_solutions/new.json
  def new
    @problem_solution = ProblemSolution.new

    if params[:problem_id]
      @problem_solution.problem = Problem.find(params[:problem_id])
    end

    respond_to do |format|
      format.html # new.html.erb
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
        format.html { redirect_to @problem_solution.problem ? solutions_by_problem_path(@problem_solution.problem) : :problem_solutions, notice: 'Решение проблемы успешно создано.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PUT /problem_solutions/1
  # PUT /problem_solutions/1.json
  def update
    @problem_solution = ProblemSolution.find(params[:id])

    respond_to do |format|
      if @problem_solution.update_attributes(params[:problem_solution])
        format.html { redirect_to @problem_solution.problem ? solutions_by_problem_path(@problem_solution.problem) : :problem_solutions, notice: 'Решение проблемы успешно обновлено.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /problem_solutions/1
  # DELETE /problem_solutions/1.json
  def destroy
    @problem_solution = ProblemSolution.find(params[:id])
    @problem = @problem_solution.problem

    @problem_solution.destroy

    respond_to do |format|
      format.html { redirect_to (@problem ? solutions_by_problem_path(@problem) : :problem_solutions), notice: 'Решение проблемы успешно удалено.' }
    end
  end
end
