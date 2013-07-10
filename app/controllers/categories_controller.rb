class CategoriesController < ApplicationController
  before_filter :require_login

  load_and_authorize_resource

  # GET /categories
  # GET /categories.json
  def index
    @categories = Category.accessible_by(current_ability)

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /categories/new
  # GET /categories/new.json
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to :categories, notice: 'Категория успешно создана.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.json
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to :categories, notice: 'Категория успешно обновлена.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to :categories, notice: 'Категория успешно удалена.' }
    end
  end
end
