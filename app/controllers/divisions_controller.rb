class DivisionsController < ApplicationController
  before_filter :require_login

  load_and_authorize_resource

  # GET /divisions
  def index
    @divisions = Division.accessible_by(current_ability)

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /divisions/new
  def new
    @division = Division.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /divisions/1/edit
  def edit
    @division = Division.find(params[:id])
  end

  # POST /divisions
  def create
    @division = Division.new(params[:division])

    respond_to do |format|
      if @division.save
        format.html { redirect_to :divisions, notice: 'Подразделение успешно создано.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /divisions/1
  def update
    @division = Division.find(params[:id])

    respond_to do |format|
      if @division.update_attributes(params[:division])
        format.html { redirect_to :divisions, notice: 'Подразделение успешно обновлено.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /divisions/1
  def destroy
    @division = Division.find(params[:id])
    @division.destroy

    respond_to do |format|
      format.html { redirect_to :divisions, notice: 'Подразделение успешно удалено.' }
    end
  end
end
