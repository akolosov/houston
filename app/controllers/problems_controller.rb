# encoding: utf-8
class ProblemsController < ApplicationController
  before_filter :require_login

  load_and_authorize_resource

  # GET /problems
  # GET /problems.json
  def index
    params[:tag_id] ?
      @problems = Problem.problems_by_tag(Tag.find(params[:tag_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC') :
      params[:solution_id] ?
        @problems = Problem.problems_by_solution(Solution.find(params[:solution_id])).paginate(page: params[:page], per_page: 5).order('updated_at DESC') :
        @problems = Problem.accessible_by(current_ability).paginate(page: params[:page], per_page: 5).order('updated_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  # GET /problems/new
  # GET /problems/new.json
  def new
    @problem = Problem.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /problems/1/edit
  def edit
    @problem = Problem.find(params[:id])
  end

  # POST /problems
  # POST /problems.json
  def create
    @problem = Problem.new(params[:problem])

    respond_to do |format|
      if @problem.save
        format.html { redirect_to :problems, notice: 'Проблема успешно создана.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PUT /problems/1
  # PUT /problems/1.json
  def update
    @problem = Problem.find(params[:id])

    respond_to do |format|
      if @problem.update_attributes(params[:problem])
        format.html { redirect_to :problems, notice: 'Проблема успешно обновлена.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /problems/1
  # DELETE /problems/1.json
  def destroy
    @problem = Problem.find(params[:id])
    @problem.destroy

    respond_to do |format|
      format.html { redirect_to :problems, notice: 'Проблема успешно удалена.' }
    end
  end
end
