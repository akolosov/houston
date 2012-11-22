# encoding: utf-8
class ServerProblemsController < ApplicationController
  skip_before_filter :require_login

  load_and_authorize_resource

  # GET /server_problems
  # GET /server_problems.json
  def index
    if (params[:problem_id]) 
      @server_problems = ServerProblem.find_all_by_problem_id(params[:problem_id])
    elsif (params[:server_id]) 
      @server_problems = ServerProblem.find_all_by_server_id(params[:server_id])
    else
      @server_problems = ServerProblem.accessible_by(current_ability)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @server_problems }
    end
  end

  # GET /server_problems/1
  # GET /server_problems/1.json
  def show
    @server_problem = ServerProblem.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @server_problem }
    end
  end

  # GET /server_problems/new
  # GET /server_problems/new.json
  def new
    @server_problem = ServerProblem.new

    if (params[:problem_id]) 
      @server_problem.problem = Problem.find(params[:problem_id])
    end

    if (params[:server_id]) 
      @server_problem.server = Server.find(params[:server_id])
    end

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @server_problem }
    end
  end

  # GET /server_problems/1/edit
  def edit
    @server_problem = ServerProblem.find(params[:id])
  end

  # POST /server_problems
  # POST /server_problems.json
  def create
    @server_problem = ServerProblem.new(params[:server_problem])

    respond_to do |format|
      if @server_problem.save
        format.html { redirect_to (@server_problem.server ? problems_by_server_path(@server_problem.server) : :server_problems), notice: 'Проблема для сервера успешно создана.' }
        format.json { render json: @server_problem, status: :created, location: @server_problem }
      else
        format.html { render action: "new" }
        format.json { render json: @server_problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /server_problems/1
  # PUT /server_problems/1.json
  def update
    @server_problem = ServerProblem.find(params[:id])

    respond_to do |format|
      if @server_problem.update_attributes(params[:server_problem])
        format.html { redirect_to (@server_problem.server ? problems_by_server_path(@server_problem.server) : :server_problems), notice: 'Проблема для сервера успешно обновлена.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @server_problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /server_problems/1
  # DELETE /server_problems/1.json
  def destroy
    @server_problem = ServerProblem.find(params[:id])
    @server_problem.destroy

    respond_to do |format|
      format.html { redirect_to server_problems_url }
      format.json { head :no_content }
    end
  end
end
