class ServicesController < ApplicationController
  include TheSortableTreeController::Rebuild

  before_filter :require_login

  load_and_authorize_resource

  # GET /services
  def index
    @divisions = Division.accessible_by(current_ability).all

    respond_to do |format|
      format.html # index.html.erb
      format.js
    end
  end

  # GET /services/1
  def show
    @service = Service.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /services/new
  def new
    @service = Service.new
    @services = Service.accessible_by(current_ability).nested_set.select('id, name, description, parent_id').all

    if (params[:id])
      @service.parent = Service.find(params[:id])
      @service.division = @service.parent.division
    end

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /services/1/edit
  def edit
    @service = Service.find(params[:id])
    @services = Service.accessible_by(current_ability).nested_set.select('id, name, description, parent_id').all
  end

  # POST /services
  def create
    @service = Service.new(params[:service])

    respond_to do |format|
      if @service.save
        format.html { redirect_to :services, notice: 'Сервис успешно создан.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /services/1
  def update
    @service = Service.find(params[:id])

    respond_to do |format|
      if @service.update_attributes(params[:service])
        format.html { redirect_to :services, notice: 'Сервис успешно обновлен.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /services/1
  def destroy
    @service = Service.find(params[:id])
    @service.destroy

    respond_to do |format|
      format.html { redirect_to :services, notice: 'Сервис успешно удален.'  }
    end
  end

end
