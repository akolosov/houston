# encoding: utf-8
class SolutionsController < ApplicationController
  before_filter :require_login

  load_and_authorize_resource

  # GET /solutions
  # GET /solutions.json
  def index
    params[:problem_id] ?
        @solutions = Solution.paginate(page: params[:page], per_page: 5).order('updated_at DESC').find_all_by_problem_id(params[:problem_id]) :
        @solutions = Solution.accessible_by(current_ability).paginate(page: params[:page], per_page: 5).order('updated_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  # GET /solutions/new
  # GET /solutions/new.json
  def new
    @solution = Solution.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /solutions/1/edit
  def edit
    @solution = Solution.find(params[:id])
  end

  # POST /solutions
  # POST /solutions.json
  def create
    @solution = Solution.new(params[:solution])

    respond_to do |format|
      if @solution.save
        format.html { redirect_to :solutions, notice: 'Решение успешно создано.' }
      else
        format.html { render action: 'new' }
      end
    end
  end

  # PUT /solutions/1
  # PUT /solutions/1.json
  def update
    @solution = Solution.find(params[:id])

    respond_to do |format|
      if @solution.update_attributes(params[:solution])
        format.html { redirect_to :solutions, notice: 'Решение успешно обновлено.' }
      else
        format.html { render action: 'edit' }
      end
    end
  end

  # DELETE /solutions/1
  # DELETE /solutions/1.json
  def destroy
    @solution = Solution.find(params[:id])
    @solution.destroy

    respond_to do |format|
      format.html { redirect_to :solutions, notice: 'Решение успешно удалено.' }
    end
  end
end
